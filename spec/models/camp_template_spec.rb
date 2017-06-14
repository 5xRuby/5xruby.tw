require 'rails_helper'

RSpec.describe CampTemplate, type: :model do
  it { is_expected.to have_many(:camps).class_name("Activity::Camp") }

  it 'default payload is the same as the yml' do
    expect(build(:camp_template).payload['testimonials_latency']).to eq CampTemplateLoader.new.testimonials_latency
  end

  it 'use json as a string input field that parse as json automatically' do
    camp_template = build(:camp_template)
    payload = {int: Random.rand(1000), lorem: Faker::Lorem.paragraph}
    camp_template.json = payload.to_json
    expect(camp_template.payload['int']).to eq payload[:int]
    expect(camp_template.payload['lorem']).to eq payload[:lorem]
  end
end
