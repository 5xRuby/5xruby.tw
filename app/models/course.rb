class Course < ActiveRecord::Base

  ABOUT_TO_BEGIN = eval Settings.course_about_to_begin_time

  # scope macros

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
  has_and_belongs_to_many :camps, association_foreign_key: 'activity_id', class_name: "::Activity::Camp"
  has_and_belongs_to_many :talks, association_foreign_key: 'activity_id', class_name: "::Activity::Talk"

  # validation macros
  validates :title, presence: true
  validates_format_of :permalink, with: /\A\w[-|\w|\d]+\z/
  validates :summary, length: {maximum: 150}
  select2_white_list :title

  # callbacks
  before_save :force_using_ssl_iframe
  after_save :reset_category_counter

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
    the_forked = self.class.new attributes.except!('id', 'iframe_html')
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

  def available?
    nearest_stage_date > Time.now
  end

  # TODO
  def outdated?
    not available?
  end

  def remaining_days
    nearest_stage_date - Date.today
  end

  # TODO
  def about_to_begin?
    remaining_days < ABOUT_TO_BEGIN and not outdated?
  end

  private
  def force_using_ssl_iframe
    pattern = /(http:\/\/)/
    self.iframe_html.sub!(pattern, "//") if pattern.match(self.iframe_html)
  end

  def reset_category_counter
    self.category.reset_courses_count! if self.category.present?
  end
end
