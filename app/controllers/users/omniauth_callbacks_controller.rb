class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    handle_omniauth('Facebook')
  end

  def google_oauth2
    handle_omniauth('Google')
  end

  def github
    handle_omniauth('GitHub')
  end

  private

  def handle_omniauth(kind)
    # Use the session locale set earlier; use the default if it isn't available.
    I18n.locale = session[:omniauth_login_locale] || I18n.default_locale

    if user_from_omniauth.persisted?
      set_flash_message :notice, :success, kind: kind
      sign_in_and_redirect user_from_omniauth
    else
      render 'devise/registrations/new'
    end
  end

  def user_from_omniauth
    @user ||= User.from_omniauth(omniauth)
  end

  def omniauth
    @omniauth ||= Omniauth.from_auth_hash(auth_hash)
  end

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end
end
