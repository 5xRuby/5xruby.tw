namespace :dev do
  desc "Initialize development data"
  task :init, :fake do
    Rake::Task[:my_task].invoke(3, 4)
  end

  desc "Generate fake data"
  task :fake, %i[model_name count] => :environment do |task, args|
    args.with_defaults(count: 20)
    count = args[:count].to_i if args[:count]
    if model_name = args[:model_name]
      FactoryGirl.create_list(model_name.underscore, count)
    else
      %i[post speaker course faq].each do |name|
        FactoryGirl.create_list(name, 20)
      end
    end
  end
end
