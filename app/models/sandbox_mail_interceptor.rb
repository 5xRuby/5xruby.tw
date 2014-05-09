class SandboxMailInterceptor
  def self.delivering_email(message)
    message.subject = "to:#{message.to} cc:#{message.cc} bcc:#{message.bcc} #{message.subject}"
    recipient = Settings.recipient
    message.to = recipient
    message.cc = nil
    message.bcc = nil
  end
end