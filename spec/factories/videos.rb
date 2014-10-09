# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  link        :string(255)
#  summary     :string(255)
#  description :text
#  is_online   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title { Faker::Name.title }
    link 'http://www.youtube.com/embed/pgk-719mTxM'
    summary { Faker::Lorem.paragraph }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }
    is_online { rand > 0.5 }
    speakers { Speaker.order('RANDOM()').limit(2) }
  end
end
