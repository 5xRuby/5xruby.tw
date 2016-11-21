namespace :docker do
  desc 'Build docker image'
  task :build, [:name] do |task, args|
    sh "docker build -t %{name} ." % {name: 'five-times-ruby'}.merge!(args)
  end

  desc 'Create rails config file from environment variable'
  task :setup => ['docker:config:database', 'docker:config:application']

  namespace :config do
    task :database do
      uri = "postgres://%{auth}%{host}/%{name}"
      auth = ""
      auth << ENV['DB_USER'] if ENV['DB_USER'].present?
      auth << ":#{ENV['DB_PASS']}" if ENV['DB_USER'].present? && ENV['DB_PASS'].present?
      auth << "@" if ENV['DB_USER'].present?

      ENV['DATABASE_URL'] = uri % {auth: auth, host: ENV['DB_HOST'] || 'localhost', name: ENV['DB_NAME'] || 'five-times-ruby'}

      puts "Generate database.tml"

      config = ActionController::Base.renderer.render(
        inline: File.read("#{Rails.root}/config/database.yml.env"),
        type: :erb
      )

      File.write("#{Rails.root}/config/database.yml", config)
    end

    task :application do
      puts "Generate application.yml"
      config = ActionController::Base.renderer.render(
        inline: File.read("#{Rails.root}/config/application.yml.env"),
        type: :erb
      )

      File.write("#{Rails.root}/config/application.yml", config)
    end
  end
end
