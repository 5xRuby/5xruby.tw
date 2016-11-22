namespace :docker do
  desc 'Build docker image via Docker Compose'
  task :build, [:name] do |task, args|
    sh 'docker-compose build'
  end

  desc 'Start application via Docker Compose'
  task :start, [:daemon] do |task, args|
    cmd = "docker-compose up %s"

    daemon = args[:daemon] == "true"
    daemon = true if args[:daemon].nil?
    options = []
    options.push("-d") if daemon

    sh cmd % options.join(" ")
  end

  desc 'Stop application via Docker Compose'
  task :stop do
    sh 'docker-compose stop'
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
