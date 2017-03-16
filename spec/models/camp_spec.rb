require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Camp, type: :model do
  it 'use a camp_with_some_payload should have the same payload' do
    camp_with_some_payload = build(:camp_with_some_payload)
    camp = Camp.use camp_with_some_payload
    expect(camp.lorem).to eq camp_with_some_payload.payload['lorem']
    expect(camp.int).to eq camp_with_some_payload.payload['int']
  end

  it 'root_methods should be added when initialize with yml or CampSetting' do
    camp_with_yml = Camp.new
    camp_using_some_payload = Camp.use build(:camp_with_some_payload)
    Camp::RootMethods.instance_methods.each do |method|
      expect(camp_with_yml.respond_to?(method)).to eq true
      expect(camp_using_some_payload.respond_to?(method)).to eq true
    end
  end

  it 'yesterday as begin_date so begun? should be true' do
    camp = Camp.use build(:camp_begun_yesterday)
    expect(camp.begun?).to eq true
  end
  
  it 'yesterday as end_date so begun? should be true' do
    camp = Camp.use build(:camp_ended_yesterday)
    expect(camp.ended?).to eq true
  end

  it 'courses should pick up each of a corresponding course record' do 
    courses = create_list :course, 5
    courses_permalinks = courses.map(&:permalink)
    camp = Camp.use build(:camp_setting,
      {payload: {lessons: courses_permalinks.map { |permalink| {course_permalink: permalink}}}}
    )
    camp.courses.each do |c|
      expect(courses_permalinks.include?(c['record'].permalink)).to eq true
    end
  end
end
