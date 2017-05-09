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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name { Faker::Name.title }
    permalink { SecureRandom.hex(4) }
    
    transient do
      courses_count 0
      courses_since_or_ago nil
      courses_is_online true
    end

    after(:create) do |category, evaluator|
      evaluator.courses_count.times do
        category.courses << create(:course, stages_since_or_ago: evaluator.courses_since_or_ago)
      end
    end
  end
end
