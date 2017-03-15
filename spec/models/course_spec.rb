require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Course, type: :model do
  it 'reset_category_counter after_save' do
    category = create(:category)
    expect(category.courses_count).to eq 0
    3.times do
      course = build(:online_course)
      course.category = category
      course.save!
    end
    category.reload
    expect(category.courses_count).to eq 3
  end

end
