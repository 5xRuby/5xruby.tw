# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  schedule_id :integer          not null
#  speaker_id  :integer
#  start_at    :time             not null
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    schedule nil
    speaker nil
    start_at { rand(1.day).from_now }
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }
  end
end
