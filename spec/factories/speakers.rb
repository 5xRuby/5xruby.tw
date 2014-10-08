# == Schema Information
#
# Table name: speakers
#
#  id           :integer          not null, primary key
#  avatar       :string(255)
#  name         :string(255)      not null
#  summary      :text
#  is_online    :boolean          default(FALSE), not null
#  created_at   :datetime
#  updated_at   :datetime
#  role         :string(255)      default("consultant"), not null
#  title        :string(255)
#  facebook_url :string(255)
#  twitter_url  :string(255)
#  google_url   :string(255)
#  blog_url     :string(255)
#  sort_id      :integer          default(0), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :speaker do
    avatar { Faker::Image.image }
    name { Faker::Name.name }
    summary { Faker::Lorem.paragraph }
    is_online { rand > 0.5 }
    role { Speaker.role.values.sample }
    title { Faker::Name.title }
    facebook_url { Faker::Internet.url('facebook.com') }
    twitter_url { Faker::Internet.url('twitter.com') }
    google_url { Faker::Internet.url('google.com', "/+#{Faker::Internet.user_name}") }
    blog_url { Faker::Internet.url }
  end
end
