namespace :faq do
  desc 'Reload FAQ data from YAML file'
  task reload: :environment do
    Faq.transaction do
      Faq.destroy_all
      ary = YAML.load(File.read(Rails.root.join('db', 'faqs.yml')))
      Faq.create(ary)
    end
  end
end
