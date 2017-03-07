require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Course, type: :model do
  it 'build a valid instance from factory' do
    expect(build(:course).valid?).to eq true
  end
  
  it 'reset_category_counter after_save' do
    category = create(:category)
    3.times do
      course = build(:course)
      course.category = category
      course.save!
    end
    category.reload
    expect(category.courses_count).to eq 3
  end
end
