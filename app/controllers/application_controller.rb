class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def recaptcha?
    return @recaptcha if @recaptcha
    uri = URI('http://www.google.com/recaptcha/api/verify')
    post_params = {
      privatekey: Settings.recaptcha.private_key, # Your private key
      remoteip: request.ip, # The IP address of the user who solved the CAPTCHA.
      challenge: params[:recaptcha_challenge_field], #  The value of "recaptcha_challenge_field" sent via the form
      response: params[:recaptcha_response_field] # The value of "recaptcha_response_field" sent via the form
    }
    p post_params
    res = Net::HTTP.post_form(uri, post_params)
    result, error = res.body.split
    @recaptcha = result == 'true'
  end
end
