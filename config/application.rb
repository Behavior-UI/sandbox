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

    # where are the assets to be precompiled?
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "bootstrap", "fonts")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "flat-ui-official", "fonts")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "flat-ui-official", "fonts", "lato")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "behavior_ui", "fonts")
    config.assets.paths << Rails.root.join("vendor", "assets", "bower_components", "behavior_ui", "images")

    Dir[Rails.root.join("vendor/assets/bower_components/flat-ui-official/images/**")].each { |f| config.assets.paths << f }

    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.assets.precompile += %w( .png .jpg .jpeg .gif )

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
      config.fail_silently = false
      config.assets.version = '1.0.3'
      config.assets.js_compressor  = :uglifier

      # Asset pipeline precompilation whitelist
      config.assets.precompile += [
        'sandbox/bootstrap.css',
        'sandbox/sandbox-bootstrap.css',
        'sandbox/sandbox-flatui.css',
        'behavior_ui/dist/prod/js/behavior-ui.js',
        'behavior_ui/images/*',
        'behavior_ui/fonts/*',
        'flat-ui-official/images/**/*',
        'prettify.js',
        'high-stock/highstock.src.js',
        'jquery/dist/jquery.min.js',
        '*.png',
        '*.tff',
        '*.woff',
        '*.svg'
      ]

    end


    # custom CSS compressor that swaps out file paths with the resolved asset path and
    # then compresses the file
    class Transformer

      include ActionView::Helpers::AssetUrlHelper

      def compress(string)
        compressor = YUI::CssCompressor.new
        url_regex = /url\(\s*['"]?(?![a-z]+:)([^'"\)]*)['"]?\s*\)/

        # e.g. "glyphicons-halflings-regular.eot?#iefix" >
        #       [
        #         "glyphicons-halflings-regular.eot?#iefix",
        #         "glyphicons-halflings-regular.eot",
        #         "?#",
        #         "iefix"
        #       ]
        file_name_regex = /(?:([a-zA-Z\-\_\.]*)([\?|\#]*)(.*))/


        # Resolve paths in CSS file if it contains a url
        if string =~ url_regex
          # Replace relative paths in URLs with Rails asset_path helper
          string = string.gsub(url_regex) do |match|
            relative_path = $1
            begin
              # split the path to the file name; that's all that the asset lookup requires
              file = relative_path.split('/').last
              # split the file name to exclude font hacks like "?#iefix"
              file_parts = file.match(file_name_regex)
              # get the asset path
              path = Rails.application.assets[file_parts[1]].digest_path + file_parts[2] + file_parts[3]
              "url(/assets/#{path})"
            rescue
              vlog "could not resolve #{relative_path.split('/').last} - #{relative_path}"
              # fall back on the url
              "url(#{relative_path})"
            end
          end
        end
        # compress the file if we're not in dev or test
        return !Rails.env.development? && !Rails.env.test? ? compressor.compress(string) : string
      end
    end

    config.assets.css_compressor = Transformer.new


  end
end
