unless Rails.env.production?
  Faker::Config.locale = :'zh-TW'

  class Faker::Image
    class << self
      def image
        Rack::Test::UploadedFile.new(Dir[Rails.root.join('spec', 'fixtures', 'images', '*')].sample)
      end
    end
  end
end