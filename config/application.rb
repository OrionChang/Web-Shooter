require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module WebshooterV1
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
    config.assets.initialize_on_precompile = false
    
    config.paperclip_defaults = {

      :styles => { :medium => "600x600#", :thumb => "200x200#" }, 
      :url => "/screenshots/:id/:style.:extension",
      :path => "/screenshots/:id/:style.:extension",
      :storage => :fog,
      :fog_credentials => {
        :provider => "Google",
        :google_storage_access_key_id => ENV['GSTORAGE_ACCESS_KEY_ID'],
        :google_storage_secret_access_key => ENV['GSTORAGE_SECRET_ACCESS_KEY']
      },
      :fog_public => true,
      :fog_host => ENV['GSTORAGE_HOST'],
      :fog_directory => ENV['GSTORAGE_BUCKET']
    }



    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: ENV["GMAIL_DOMAIN"],
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV["GMAIL_USERNAME"],
      password: ENV["GMAIL_PASSWORD"]
    }
    
  end
end
