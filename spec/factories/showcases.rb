# == Schema Information
#
# Table name: showcases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  link        :string(255)
#  image       :string(255)
#  is_online   :boolean          default(FALSE), not null
#  sort_id     :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :showcase do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    link { Faker::Internet.url }
    image { Faker::Image.image }
    is_online { rand > 0.5 }
  end
end
