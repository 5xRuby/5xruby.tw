# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  avatar     :string(255)
#  name       :string(255)      not null
#  summary    :text
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :speaker do
    avatar { Faker::Image.image }
    name { Faker::Name.name }
    summary { Faker::Lorem.paragraph }
    is_online { [true, false].sample }
  end
end
