module Users
  class OmniauthController < ApplicationController
    def localized
      # Just save the current locale in the session and redirect to the unscoped path as before
      session[:omniauth_login_locale] = params[:locale]
      redirect_to send("user_#{params[:provider]}_omniauth_authorize_path")
    end
  end
end
