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
    first_name "MyString"
    last_name "MyString"
    phone "MyString"
    email "MyString"
    age 1
    gender "MyString"
    message "MyText"
  end
end
