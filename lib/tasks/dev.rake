namespace :dev do
  desc 'Generate fake data for all model, or dev:fake[course,3] to create 3 fake courses (available parameters: author, post, speaker, category, course, faq)'
  task :fake, %i[model_name count] => :environment do |task, args|
    args.with_defaults(count: 20)
    count = args[:count].to_i if args[:count]
    if model_name = args[:model_name]
      FactoryGirl.create_list(model_name.underscore, count)
    else
      %i[author post speaker category course faq showcase video interview_question].each do |name|
        FactoryGirl.create_list(name, 20)
      end
    end
  end
end
