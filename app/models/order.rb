# frozen_string_literal: true
class Order < ApplicationRecord
  # scope macros

  # Concerns macros
  include AASM

  # Constants
  STATE = { 'pending': 'pending',
            'success': 'success',
            'expired': 'expired' }.freeze

  # Attributes related macros
  enum state: STATE

  aasm column: :state, no_direct_assignment: true, enum: true do
    state :pending, initial: true
    state :success, :expired

    event :succeed! do
      transitions from: :pending, to: :success
    end

    event :expire! do
      transitions from: :pending, to: :expired
    end
  end

  # association macros
  belongs_to :user
  belongs_to :activity
  has_many :course_enrollments, class_name: "Order::CourseEnrollment"
  has_many :activity_courses, through: :course_enrollments
  has_many :enrolling_courses, through: :activity_courses, source: :course

  delegate :survey, to: :activity
  delegate :questions, to: :survey

  # validation macros
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validate :number_of_course_enrollments, on: :create

  # callbacks

  # other

  protected
  # callback methods
  def number_of_course_enrollments
    return unless course_enrollments.size.zero?
    errors.add(:course_enrollments, :no_course_enrollments_in_camp_registration)
  end
end
