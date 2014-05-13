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
    start_at "2014-05-13 13:40:44"
    title "MyString"
    description "MyText"
  end
end
