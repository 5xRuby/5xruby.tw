class ApplicationController < ActionController::Base
  force_ssl if Settings.force_ssl
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :set_seo
  helper_method :current_path_with_locale, :translatable_locales

  def set_seo
    @seo = {
      meta: {
        description: t('site.description')
      },
      google: {
        name: t('company.name'),
        description: t('site.description'),
        image: 'og_picture.png',
        item_type: :Article
      },
      og: {
        title: t('company.name'),
        url: request.url,
        type: :website,
        description: t('site.description'),
        image: 'og_picture.png'
      }
    }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_path_with_locale locale
    # TODO compute path by request.fullpath, locale, I18n.locale and I18n.default_locale, it's bit complex
  end

  def translatable_locales
    @translatable_locales ||= I18n.available_locales.reject{ |i| i == I18n.default_locale }
  end

  # override
  def default_url_options options = {}
    {locale: I18n.locale == I18n.default_locale ? nil : I18n.locale}
  end
end
