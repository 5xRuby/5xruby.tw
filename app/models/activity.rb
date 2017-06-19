class Activity < ApplicationRecord
  # scope macros
  CAMP = "Activity::Camp".freeze
  TALK = "Activity::Talk".freeze

  # Concerns macros
  include Permalinkable
  include PatchNestedAttributesAssignment

  # Constants

  # Attributes related macros
  permalinkable :title
  patch :activity_courses
  delegate :payload, to: :template, allow_nil: true

  # association macros
  has_and_belongs_to_many :courses, after_add: :touch_if_needed, after_remove: :touch_if_needed
  belongs_to :template, class_name: "CampTemplate", required: false
  belongs_to :survey, required: false
  has_many :translations, as: :translatable
  has_many :activity_courses
  has_many :orders, as: :purchasable
  accepts_nested_attributes_for :activity_courses, allow_destroy: true

  # validation macros
  validates :type, :title, :permalink, :note, :payment_note, presence: true
  validates :type, inclusion: { in: %w(Activity::Camp Activity::Talk) }
  validate :validate_courses_number, :validate_courses_uniqueness, :validate_template, :validate_uniqueness_of_course
  validates :permalink, uniqueness: true
  validates :is_online, inclusion: { in: [ true, false ] }
  validates_format_of :permalink, with: /\A\w[-|\w|\d]+\z/

  # callbacks
  before_validation :nullify_invalid_data, :set_title_if_needed

  # other
  def is_camp?
    type == CAMP
  end

  def is_talk?
    type == TALK
  end

  def specialized
    becomes(type.constantize)
  end

  protected
  # callback methods
  def touch_if_needed(course)
    self.touch if persisted?
  end

  def validate_courses_number
    size = activity_courses.reject{ |c| c.marked_for_destruction? }.size
    return if is_camp? && size >= 1
    return if is_talk? && size == 1
    errors.add(:type, :wrong_course_number)
  end

  def validate_courses_uniqueness
    not_destroyed_activity_courses = activity_courses.reject(&:marked_for_destruction?)
    return if not_destroyed_activity_courses.map(&:course_id).uniq.size == not_destroyed_activity_courses.size
    errors.add(:type, :course_duplicate)
  end

  def validate_template
    return if is_camp? && template.present?
    return if is_talk? && template.nil?
    if template
      errors.add(:type, :talk_has_no_template)
    else
      errors.add(:template, :camp_needs_template)
    end
  end

  def validate_uniqueness_of_course
    return if is_camp? || activity_courses.size == 0
    course = activity_courses.first.course
    return if course.talks.exists?(id) || course.talks.count == 0
    errors.add(:type, :talk_has_been_existed)
  end

  def nullify_invalid_data
    return if is_camp?
    assign_attributes(template_id: nil, title: nil, rules: "")
  end

  def set_title_if_needed
    return if is_camp? || activity_courses.size == 0
    self[:title] = activity_courses.first.course.title
  end
end
