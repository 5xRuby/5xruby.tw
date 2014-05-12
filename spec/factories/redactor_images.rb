# == Schema Information
#
# Table name: redactor_images
#
#  id         :integer          not null, primary key
#  image      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :redactor_image do
    image "MyString"
  end
end
