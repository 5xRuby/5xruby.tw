FactoryGirl.define do
  factory :index_picture do
    alt { Faker::Lorem.sentence }
    href { Faker::Internet.url }

    transient do
      index_picture_imgs_count 3
    end

    after(:build) do |ip, evaluator|
      ip.index_picture_imgs = create_list(:index_picture_img, evaluator.index_picture_imgs_count, index_picture: ip) if ip.index_picture_imgs.blank?
    end
  end
end
