# == Schema Information
#
# Table name: courses
#
#  id                :integer          not null, primary key
#  image             :string(255)
#  title             :string(255)      not null
#  summary           :text
#  description       :text
#  what_will_learn   :text
#  created_at        :datetime
#  updated_at        :datetime
#  subtitle          :string(255)
#  category_id       :integer
#  is_online         :boolean          default(FALSE), not null
#  permalink         :string(255)      not null
#  note              :text
#  apply_link        :string(255)
#  iframe_html       :string(255)
#  maximum_attendees :integer          default(30), not null
#  total_attendees   :integer          default(0), not null
#  minimum_attendees :integer          default(5), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    category { Category.order('RANDOM()').first }
    image { Faker::Image.image }
    title { Faker::Name.title }
    permalink { SecureRandom.hex(4) }
    is_online { rand > 0.5 }
    subtitle { Faker::Lorem.sentence }
    summary { Faker::Lorem.paragraph.slice(0, 150) }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }
    note { "<p>#{Faker::Lorem.paragraph}</p>" }
    what_will_learn { "<p>#{Faker::Lorem.paragraph}</p>" }
    maximum_attendees { 30 }
    total_attendees { rand(30) }
    minimum_attendees { 5 + rand(5) }

    transient do
      stages_count 6
      stages_since_or_ago :random
    end

    after(:build) do |course, evaluator|
      since_or_ago = evaluator.stages_since_or_ago == :random ? (rand > 0.5 ? :since : :ago) : evaluator.stages_since_or_ago
      stages = build_list(:stage, evaluator.stages_count, since_or_ago)
      course.stages = stages
      course.speakers = Speaker.order('RANDOM()').limit(2)
    end
    
    factory :course_since do
      stages_since_or_ago :since
    end
    factory :course_ago do
      stages_since_or_ago :ago
    end
    
    factory :online_course do
      is_online true
    end
  end
end

