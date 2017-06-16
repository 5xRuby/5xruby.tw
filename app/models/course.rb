class Course < ActiveRecord::Base

  ABOUT_TO_BEGIN = eval Settings.course_about_to_begin_time

  # scope macros

  # Concerns macros
  include Select2Concern

  # Constants

  # Attributes related macros
  mount_uploader :image, CourseImageUploader

  # association macros
  has_many :stages, -> { order(:date, :start_at) }, dependent: :destroy
  accepts_nested_attributes_for :stages, allow_destroy: true, reject_if: proc { |attributes| attributes[:title].blank? }
  has_and_belongs_to_many :speakers
  belongs_to :category, counter_cache: true
  has_many :translations, as: :translatable
  has_many :activity_courses
  has_and_belongs_to_many :camps, association_foreign_key: 'activity_id', class_name: "::Activity::Camp"
  has_and_belongs_to_many :talks, association_foreign_key: 'activity_id', class_name: "::Activity::Talk"

  # validation macros
  validates :title, :time_description, :time_limit, presence: true
  validates_format_of :permalink, with: /\A\w[-|\w|\d]+\z/
  validates :summary, length: {maximum: 150}
  select2_white_list :title

  # callbacks
  before_save :force_using_ssl_iframe
  after_save :reset_category_counter
  after_initialize :set_defualt_values, if: :new_record?, unless: :changed?

  # other
  class << self
    def all_with_humanized_name(order: :desc, time_range: 12)
      courses = all.includes(:stages).select { |c| c.start_on && c.start_on > (Time.current - time_range.months) }.sort_by(&:start_on)
      courses.reverse! if order == :desc
      courses.map{|c| [[c.start_on, c.title].join("－"), c.id] }
    end
  end

  def fork
    the_forked = self.class.new attributes.except!('id', 'iframe_html')
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
    stages.first&.date
  end

  def end_on
    stages.last&.date
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

  def outdated?
    not available?
  end

  def remaining_days
    nearest_stage_date - Date.today
  end

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

  def set_defualt_values
    self[:time_limit] = Time.zone.now.strftime('%Y-%m-%d %H:%M')
  end
end
