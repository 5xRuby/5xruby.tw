require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Category, type: :model do
  it 'reset_courses_count!' do
    category = create(:category)
    3.times do
      course = build(:course)
      course.category = category
    end
    category.reset_courses_count!
    expect(category.courses_count).to eq 3
  end

end
