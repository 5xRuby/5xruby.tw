class Activity < ApplicationRecord
  # scope macros

  # Concerns macros
  # TODO: add permalinkable

  # Constants

  # Attributes related macros

  # association macros
  has_and_belongs_to_many :courses, after_add: :touch_if_needed, after_remove: :touch_if_needed
  belongs_to :template, class_name: "CampTemplate", required: false
  has_many :translations, as: :translatable
  has_many :activity_courses
  accepts_nested_attributes_for :activity_courses, allow_destroy: true

  # validation macros
  validates :type, :title, :is_online, :permalink, :note, :payment_note, presence: true
  validates :type, inclusion: { in: %w(Activity::Camp Activity::Talk) }
  validate :validate_courses_number
  validate :validate_courses_uniqueness
  validate :validate_template
  validates :permalink, uniqueness: true

  # callbacks

  # other

  protected
  # callback methods
  def touch_if_needed(course)
    self.touch if persisted?
  end

  def validate_courses_number
    size = activity_courses.reject{ |c| c.marked_for_destruction? }.size
    return if type == "Activity::Camp" && size >= 1
    return if type == "Activity::Talk" && size == 1
    errors.add(:type, :wrong_course_number)
  end

  def validate_courses_uniqueness
    return if activity_courses.map(&:course_id).uniq.size == activity_courses.size
    errors.add(:type, :course_duplicate)
  end

  def validate_template
    return if type == "Activity::Camp" && template.present?
    return if type == "Activity::Talk" && template.nil?
    if template
      errors.add(:type, :talk_has_no_template)
    else
      errors.add(:template, :camp_needs_template)
    end
  end
end
