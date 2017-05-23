Rails.application.configure do
  Settings.action_mailer.each do |key, value|
    config.action_mailer.send("#{key}=", value)
  end
end

#ActionMailer::Base.register_interceptor(SandboxMailInterceptor) if Rails.env.development?

#if Rails.env.production? || Settings['use_real_mailer_in_dev']
  #Rails.application.configure do
    #Settings.action_mailer.each do |key, value|
      #config.action_mailer.send("#{key}=", value)
    #end
  #end
#end
