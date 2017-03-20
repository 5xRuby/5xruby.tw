unless Rails.env.production? || Rails.env.staging?
  Faker::Config.locale = :'zh-TW'

  class Faker::Image
    class << self
      def image
        Rack::Test::UploadedFile.new(Dir[Rails.root.join('spec', 'fixtures', 'images', '*')].sample)
      end
    end
  end
end
