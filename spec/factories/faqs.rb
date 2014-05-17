# == Schema Information
#
# Table name: faqs
#
#  id         :integer          not null, primary key
#  question   :text             not null
#  answer     :text             not null
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq do
    question { Faker::Lorem.paragraph }
    answer { Faker::Lorem.paragraph }
    is_online { [true, false].sample }
  end
end
