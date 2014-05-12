# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text             not null
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    image { Faker::Image.image }
    title { Faker::Name.title }
    content { "<p>#{Faker::Lorem.paragraph}</p>" }
  end
end
