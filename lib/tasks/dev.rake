namespace :dev do
  desc "Generate fake data"
  task :fake, %i[model_name count] => :environment do |task, args|
    args.with_defaults(count: 20)
    count = args[:count].to_i if args[:count]
    if model_name = args[:model_name]
      FactoryGirl.create_list(model_name.underscore, count)
    else
      %i[author post speaker category course faq].each do |name|
        FactoryGirl.create_list(name, 20)
      end
    end
  end
end
