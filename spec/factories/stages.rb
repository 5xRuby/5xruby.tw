# == Schema Information
#
# Table name: stages
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  date        :date             default(Wed, 03 Sep 2014), not null
#  start_at    :time             default(2000-01-01 00:00:00 UTC), not null
#  end_at      :time             default(2000-01-01 00:00:00 UTC), not null
#  hours       :float            default(1.0), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stage do
    course nil
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    date { rand(1.month).since }
    start_at { rand(1.hour).since }
    end_at { (rand(1.hour) + 3600).since }
  end
end
