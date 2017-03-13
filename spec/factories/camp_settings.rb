FactoryGirl.define do
  locales = CampSetting::LOCALES
  factory :camp_setting do
    lang { locales.sample }

    locales.each do |locale|
      factory :"camp_setting_with_lang_#{locale}" do
        lang locale
      end
    end

    factory :camp_setting_no_lang do
      lang nil
    end

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
