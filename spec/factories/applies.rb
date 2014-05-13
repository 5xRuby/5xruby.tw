# == Schema Information
#
# Table name: applies
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  stage_id    :integer
#  schedule_id :integer
#  first_name  :string(255)      not null
#  last_name   :string(255)      not null
#  phone       :string(255)
#  email       :string(255)      not null
#  age         :integer
#  gender      :string(255)
#  message     :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :apply do
    course nil
    stage nil
    schedule nil
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    age { 20 + rand(81) }
    gender { Apply.gender.values.sample }
    message { Faker::Lorem.paragraph }
  end
end
