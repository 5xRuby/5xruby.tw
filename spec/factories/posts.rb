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
#  author_id  :integer
#  summary    :text
#  is_online  :boolean          default(FALSE), not null
#  permalink  :string(255)      not null
#  publish_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    author { Author.order('RANDOM()').first }
    image { Faker::Image.image }
    title { Faker::Name.title }
    permalink { SecureRandom.hex(4) }
    is_online { rand > 0.5 }
    publish_at { rand(1.month).seconds.ago }
    summary { Faker::Lorem.paragraph[0,150] }
    content { "<p>#{Faker::Lorem.paragraph}</p>" }
    tag_list { %w[aaa bbb ccc ddd eee fff ggg hhh iii jjj].sample(3) }
  end
end
