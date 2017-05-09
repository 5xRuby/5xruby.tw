class Category < ActiveRecord::Base
  # scope macros
  scope :with_max_date, -> { select('categories.*, max(date) as max_date').joins(courses: :stages).group('categories.id') }

  # Concerns macros
  include Permalinkable

  # Constants

  # Attributes related macros
  permalinkable

  def reset_courses_count!
    self.courses_count = self.courses.count
    self.save!
  end

  # association macros
  has_many :courses
  has_many :talks, -> { where(is_online: true) },through: :courses

  # validation macros
  validates :name, presence: true

  # callbacks

  # other
  def new_course?
    if respond_to?(:max_date)
      max_date > Time.now
    else
      logger.warn 'Use `Category.with_max_date` for better performance.'
      courses_with_max_data = courses.select('courses.*, max(date) as max_date').joins(:stages).group('courses.id').order('max_date desc').first
      courses_with_max_data.present? ? courses_with_max_data.max_date > Time.now : false
    end
  end
end
