FactoryGirl.define do
  factory :camp_setting do
    #payload nil
    #status nil
    lang { CampSetting::LOCALES.sample }
  end
end
