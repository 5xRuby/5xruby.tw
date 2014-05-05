class AdminController < ApplicationController
  http_basic_authenticate_with Settings.http_basic_auth.to_h if Rails.env.production?
  def dashboard
  end
end
