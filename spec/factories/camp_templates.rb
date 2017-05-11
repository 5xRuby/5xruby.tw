FactoryGirl.define do
  factory :camp_template do
    factory :camp_with_some_payload do
      payload { {int: Random.rand(1000), lorem: Faker::Lorem.paragraph} }
    end

    factory :camp_begun_yesterday do
      payload { {begin_date: DateTime.yesterday.strftime('%Y/%m/%d')} }
    end

    factory :camp_ended_yesterday do
      payload { {end_date: DateTime.yesterday.strftime('%Y/%m/%d')} }
    end
  end
end
