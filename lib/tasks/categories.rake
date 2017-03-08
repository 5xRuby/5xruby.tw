namespace :categories do
  desc 'reset_counters'
  task reset_counters: :environment do
    Category.find_each do |category|
      Category.reset_counters category.id, :courses
      category.reload
      puts "category '#{category.name}' [#{category.id}] courses_count reset to #{category.courses_count}!"
    end
  end
end
