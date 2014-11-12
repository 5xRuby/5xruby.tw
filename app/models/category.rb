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
  scope :available, -> { joins(courses: :stages).where(courses: {is_online: :true}) }

  # Concerns macros
  include Permalinkable

  # Constants
  
  # Attributes related macros
  permalinkable

  # association macros
  has_many :courses

  # validation macros
  validates :name, presence: true

  # callbacks

  # other
  def new_course?
    courses.each do |course|
      course.stages.each do |stage|
        return true if stage.date > Time.now
      end
    end
    return false
  end

  protected
  # callback methods
end
