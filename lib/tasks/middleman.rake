namespace :middleman do
  desc 'Export post to middleman format'
  task export_posts: :environment do

    output_path = ENV['OUTPUT']
    if !File.directory?(output_path) || !File.writable?(output_path)
      puts "The output path does not exist or not writable, please use corect one and set it in OUTPUT variable"
      exit
    end
    Post.include MiddlemanPostRenderer

    Dir.chdir output_path do
      Post.online.each do |post|
        puts "Exporting Post #{post.id}"
        buf = post.as_middleman_post
        File.write post.output_file_name, buf
      end
    end

  end
end
