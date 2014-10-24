class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :set_seo
  helper_method :current_path_with_locale, :translate_record, :tr

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
    Translation.find_by(translatable: record, column: attribute, locale: I18n.locale).try(:text).presence || record.send(attribute)
  end
  alias :tr :translate_record

  # override
  def default_url_options options = {}
    {locale: I18n.locale == I18n.default_locale ? nil : I18n.locale}
  end
end
