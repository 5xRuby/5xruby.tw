# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#  courses_count  :integer          default(0), not null
#  is_highlighted :boolean          default(FALSE), not null
#  sort_id        :integer          default(0), not null
#  permalink      :string(255)      not null
#

class Category < ActiveRecord::Base
  # scope macros
  scope :with_max_date, -> { select('categories.*, max(date) as max_date').joins(courses: :stages).group('categories.id') }

  # Concerns macros
  include Permalinkable

  # Constants
  
  # Attributes related macros
  permalinkable

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

  protected
  # callback methods
end
