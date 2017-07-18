require 'rails_helper'

RSpec.describe CampTemplate, type: :model do
  it { is_expected.to have_many(:camps).class_name("Activity::Camp") }

  it 'default payload is the same as the yml' do
    expect(build(:camp_template).payload[:testimonials_latency]).to eq CampTemplateLoader.new[:testimonials_latency]
  end
end
