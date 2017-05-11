require 'rails_helper'
require 'support/factory_girl'

RSpec.describe CampTemplate, type: :model do
  it { is_expected.to belong_to(:camp).class_name("Activity::Camp") }

  it 'default payload is the same as the yml' do
    expect(build(:camp_template).payload['title']).to eq CampTemplateLoader.title
  end

  it 'use json as a string input field that parse as json automatically' do
    camp_template = build :camp_template
    payload = {int: Random.rand(1000), lorem: Faker::Lorem.paragraph}
    camp_template.json = payload.to_json
    expect(camp_template.payload['int']).to eq payload[:int]
    expect(camp_template.payload['lorem']).to eq payload[:lorem]
  end

  it 'ensure_only_one_active' do
    camp_template = create_list :camp_template, 3
    camp_template[0].active!

    camp_template.each(&:reload)
    camp_template[1..2].each do |cs|
      expect(cs.active?).to eq false # only camp_template[0] should be active
    end
    expect(camp_template[0].active?).to eq true # only camp_template[0] should be active

    camp_template[2].active!

    camp_template.each(&:reload)
    camp_template[0..1].each do |cs|
      expect(cs.active?).to eq false # only camp_template[2] should be active
    end
    expect(camp_template[2].active?).to eq true # only camp_template[2] should be active
  end
end
