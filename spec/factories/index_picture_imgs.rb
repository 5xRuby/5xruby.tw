FactoryGirl.define do
  factory :index_picture_img do
    src { Faker::Image.image }
    lang { IndexPictureImg::LOCALES.sample }
    size { IndexPictureImg::SIZES.sample }
    after(:build) do |img|
      img.index_picture ||= create(:index_picture)
    end
  end
end
