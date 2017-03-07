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
  has_many :courses, -> { where(is_online: true) }

  # validation macros
  validates :name, presence: true

  # callbacks

  # other
  def new_course?
    if respond_to?(:max_date)
      max_date > Time.now
    else
      logger.warn 'Use `Category.with_max_date` for better performance.'
      courses.select('courses.*, max(date) as max_date').joins(:stages).group('courses.id').order('max_date desc').first.max_date > Time.now
    end
  end
end
