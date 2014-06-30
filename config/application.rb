require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "rails/test_unit/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Sandbox
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    #

    # Don't load application on asset precompilation
    config.assets.initialize_on_precompile = false

    config.less.paths << Rails.root.join("vendor", "assets", "bower_components")
    config.less.paths << Rails.root.join("vendor", "assets", "bower_components", "behavior_ui", "less")

    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "behavior_ui")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "behavior_ui", "sandbox", "doc_assets")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "bootstrap")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "flat-ui-official")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "flat-ui-official", "fonts")

    config.assets.precompile += %w( .svg .eot .woff .ttf )

    # Enable the asset pipeline
    config.assets.enabled = true

    # For all Heroku deployed environments:
    if !Rails.env.development? && !Rails.env.test?
      # Disable Rails's static asset server
      # In production, Apache or nginx will already do this
      config.serve_static_assets = true
      config.assets.compile = true
      config.assets.compress = true
      config.assets.digest = true
      config.assets.enabled = true
      config.fail_silently = true
      config.assets.version = '1.0.2'
      config.assets.js_compressor  = :uglifier
      config.assets.css_compressor = :yui

      # Asset pipeline precompilation whitelist
      config.assets.precompile += [
        'sandbox/bootstrap.css',
        'sandbox/sandbox-bootstrap.css',
        'sandbox/sandbox-flatui.css',
        'behavior_ui/dist/js/*.js',
        'app/assets/javascripts/*.js'
      ]

    end

  end
end
