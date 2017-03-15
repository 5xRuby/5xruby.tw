require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PentaRuby
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Taipei'
    config.i18n.available_locales = %i[en zh-TW ja]
    config.i18n.default_locale = :'zh-TW'
    #config.active_record.time_zone_aware_types = [:datetime, :time]

    config.generators do |g|
      g.assets           = false
      g.helper           = false
      g.jbuilder         = false
      g.view_specs       = false
      g.helper_specs     = false
      g.controller_specs = false
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    config.autoload_paths += Dir[Rails.root.join('lib')]
  end
end
