namespace :update_record do
  
  namespace :categories do
    desc 'reset categories counters'
    task reset_counters: :environment do
      Category.find_each do |category|
        Category.reset_counters category.id, :courses
        category.reload
        puts "category '#{category.name}' [#{category.id}] courses_count reset to #{category.courses_count}!"
      end
    end
  end
  
  namespace :posts do
    desc 'set posts image dimensions'
    task set_image_dimensions: :environment do
      Post.find_each do |post|
        if (file = post.image.file).present?
          img = ::Magick::Image::read(file.path).first
          post.image_width = img.columns
          post.image_height = img.rows
          post.save!
          puts "post [#{post.id}] image dimensions reset to [#{post.image_width}, #{post.image_height}]!"
        else
          puts "post [#{post.id}] has no image!"
        end
      end
    end
  end

end
