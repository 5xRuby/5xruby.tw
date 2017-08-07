class ApplicationController < ActionController::Base
  force_ssl if Settings.force_ssl
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :set_seo
  before_action :set_nav_camp_online
  helper_method :current_path_with_locale, :translate_record, :tr, :translatable_locales

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

  def translate_record record, attribute
    record.translations.find{ |t| t.column == attribute.to_s && t.locale == I18n.locale.to_s }.try(:text).presence || record.send(attribute)
  end
  alias :tr :translate_record

  def translatable_locales
    @translatable_locales ||= I18n.available_locales.reject{ |i| i == I18n.default_locale }
  end

  # override
  def default_url_options options = {}
    {locale: I18n.locale == I18n.default_locale ? nil : I18n.locale}
  end

  def set_nav_camp_online
    @camps_online = Activity::Camp.online.order(:id)
  end
end
