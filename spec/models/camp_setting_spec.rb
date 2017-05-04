require 'rails_helper'
require 'support/factory_girl'

RSpec.describe CampSetting, type: :model do
  locales = CampSetting::LOCALES
  
  it 'default payload is the same as the yml' do
    expect(build(:camp_setting).payload['title']).to eq CampTemplateLoader.title
  end

  it 'query scope lang_or_none for a lang when the target lang not exists, it looks for lang is nil' do
    target_lang = locales.sample
    (locales - [target_lang]).each do |locale|
      create :"camp_setting_with_lang_#{locale}"
    end
    create :camp_setting_no_lang
    expect(CampSetting.lang_or_none(target_lang).first.lang).to eq nil
  end
  
  it 'query scope lang_or_any for a lang when the target lang not exists, it looks for lang is any' do
    target_lang = locales.sample
    (locales - [target_lang]).each do |locale|
      create :"camp_setting_with_lang_#{locale}"
    end
    create :camp_setting_no_lang
    camp_settings = CampSetting.lang_or_any(target_lang)
    camp_settings.each do |cs|
      expect(cs.lang).not_to eq target_lang
    end
    expect(camp_settings.count).to eq locales.count
  end

  it 'use json as a string input field that parse as json automatically' do
    camp_setting = build :camp_setting
    payload = {int: Random.rand(1000), lorem: Faker::Lorem.paragraph}
    camp_setting.json = payload.to_json
    expect(camp_setting.payload['int']).to eq payload[:int]
    expect(camp_setting.payload['lorem']).to eq payload[:lorem]
  end

  it 'ensure_only_one_active' do
    camp_settings = create_list :camp_setting, 3, lang: locales.sample
    camp_settings[0].active!
    
    camp_settings.each(&:reload)
    camp_settings[1..2].each do |cs|
      expect(cs.active?).to eq false # only camp_settings[0] should be active
    end
    expect(camp_settings[0].active?).to eq true # only camp_settings[0] should be active
    
    camp_settings[2].active!
    
    camp_settings.each(&:reload)
    camp_settings[0..1].each do |cs|
      expect(cs.active?).to eq false # only camp_settings[2] should be active
    end
    expect(camp_settings[2].active?).to eq true # only camp_settings[2] should be active
  end
end
