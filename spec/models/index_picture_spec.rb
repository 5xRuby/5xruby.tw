require 'rails_helper'
require 'support/factory_girl'

RSpec.describe IndexPicture, type: :model do
  it 'index_picture should at least has one img' do
    index_picture = build :index_picture, index_picture_imgs_count: 0
    expect(index_picture.valid?).to eq false
    expect(index_picture.errors.details[:index_picture_imgs].first[:error]).to eq :blank
  end
  
  it 'srcs should construct a [lang][size] => IndexPictureImg.src hash' do
    index_picture = create :index_picture_with_all_variance_imgs
    IndexPictureImg::LOCALES.map(&:to_sym).each do |locale|
      IndexPictureImg::SIZES.map(&:to_sym).each do |size|
        expect(index_picture.srcs[locale][size].present?).to eq true
      end
    end
  end
  
  it 'srcset and src with a lang should return the selected lang\'s imgs' do
    index_picture = build :index_picture, index_picture_imgs_count: 0
    target_lang = IndexPictureImg::LOCALES.sample

    # construct imgs in other language
    (IndexPictureImg::LOCALES - [target_lang]).each do |lang|
      index_picture.index_picture_imgs << create(:index_picture_img, index_picture: index_picture, lang: lang)
    end

    # so srcset and src in the target langugage should be blank
    expect(index_picture.srcset(target_lang).blank?).to eq true
    expect(index_picture.src(target_lang).blank?).to eq true
  end
end
