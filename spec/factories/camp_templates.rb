FactoryGirl.define do
  factory :camp_template do
    title { Faker::Name.name }
    payload { CampTemplateLoader.new }
  end
end
