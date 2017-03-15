require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Category, type: :model do
  it 'reset_courses_count! should set courses_count correctly' do
    category = create(:category, courses_count: 3)
    category.courses_count = 0
    category.reset_courses_count!
    expect(category.courses_count).to eq 3
  end

  it 'new_course? should only be true when has courses that havent begun' do
    category = create(:category, courses_count: 1, courses_since_or_ago: :ago)
    expect(category.new_course?).to eq false # with one course ago
    expect(Category.with_max_date.where(id: category.id).first.new_course?).to eq false # with one course ago
    
    category = create(:category, courses_count: 1, courses_since_or_ago: :since)
    expect(category.new_course?).to eq true # with one course since
    expect(Category.with_max_date.where(id: category.id).first.new_course?).to eq true # with one course since
    
    category = create(:category, courses_count: 0)
    expect(category.new_course?).to eq false # without course
  end

end
