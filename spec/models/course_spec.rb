require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to have_and_belong_to_many(:camps) }
  it { is_expected.to have_and_belong_to_many(:talks) }

  it 'reset_category_counter after_save' do
    category = create(:category)
    expect(category.courses_count).to eq 0
    3.times do
      course = build(:course)
      course.category = category
      course.save!
    end
    category.reload
    expect(category.courses_count).to eq 3
  end

end
