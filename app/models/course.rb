class Course < ActiveRecord::Base
  
  ABOUT_TO_BEGIN = eval Settings.course_about_to_begin_time

  # scope macros
  scope :online, -> { where(is_online: true) }
  scope :coming, -> { select('courses.*, min(date) as min_date').joins(:stages).group('courses.id').order('min_date') }
  scope :available, -> { online.where('stages.date >= ?', Time.now).joins(:stages).distinct }

  # Concerns macros
  include Select2Concern
  include Permalinkable

  # Constants

  # Attributes related macros
  mount_uploader :image, CourseImageUploader
  permalinkable :title

  # association macros
  has_many :stages, -> { order(:date, :start_at) }, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: proc { |attributes| attributes[:title].blank? }
  has_and_belongs_to_many :speakers
  belongs_to :category, counter_cache: true
  has_many :translations, as: :translatable

  # validation macros
  validates :title, presence: true
  validates_format_of :permalink, with: /\A\w[-|\w|\d]+\z/
  validates :summary, length: {maximum: 150}
  select2_white_list :title

  # callbacks
  before_save :force_using_ssl_iframe

  # other

  # This query seperates courses by their expiration date,
  # orders comming-soon courses descendingly and expired course ascendingly.
  #     comming soon course (latest)
  #     comming soon course
  #     comming soon course
  #     ...
  #     expired course (latest)
  #     expired course
  #     expired course
  #     ...
  def self.magic_scope # TODO Find a better name.
    ret = select('courses.*, min_date, max_date, case when max_date < now() then true else false end as outdated')
    ret = ret.joins('inner join (select courses.id, min(date) as min_date, max(date) as max_date from courses inner join stages on courses.id = course_id group by courses.id) as r on r.id = courses.id')
    ret = ret.order('outdated, case max_date < now() when true then min_date end desc, case max_date < now() when false then min_date end asc')
  end

  def fork
    the_forked = self.class.new attributes.except!('id', 'iframe_html', 'is_online')
    the_forked.permalink = the_forked.next_permalink
    the_forked.speakers = speakers
    the_forked.image = image
    stages.each do |stage|
      the_forked.stages << Stage.new(stage.attributes.except!('id'))
    end
    the_forked
  end

  def hours
    stages.inject(0){|memo, stage| memo += stage.hours }
  end

  def start_on
    stages.first.date
  end

  def end_on
    stages.last.date
  end

  def need_attendees_count
    need_attendees = minimum_attendees - total_attendees
    need_attendees < 0 ? 0 : need_attendees
  end

  def need_attendees_percent
    (((minimum_attendees - need_attendees_count).to_f / minimum_attendees) * 100).to_i
  end

  def nearest_stage_date
    stages.map(&:date).max
  end

  def outdated?
    nearest_stage_date < Time.now
  end

  def about_to_begin?
    (Date.today - nearest_stage_date) < ABOUT_TO_BEGIN
  end

  private
  def force_using_ssl_iframe
    pattern = /(http:\/\/)/
    self.iframe_html.sub!(pattern, "//") if pattern.match(self.iframe_html)
  end
end
