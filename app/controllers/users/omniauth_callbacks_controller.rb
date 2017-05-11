class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  helper_method :resource

  def facebook
    handle_omniauth
  end

  def google_oauth2
    handle_omniauth
  end

  private

  def handle_omniauth
    if user_from_omniauth.persisted?
      set_flash_message :notice, :success, 'Login ok'
      sign_in_and_redirect user_from_omniauth, root_path
    else
      render 'devise/registrations/new'
    end
  end

  def user_from_omniauth
    @user ||= User.from_omniauth(auth_hash)
  end
  alias :resource :user_from_omniauth

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end
end

