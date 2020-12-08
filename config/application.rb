require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsApp1204
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.template_engine :slim
      g.helper false      # ヘルパーを生成しない
      g.assets false      # CSS, JavaScript ファイルを生成しない
      g.skip_routes true  # config/routes.rb を変更しない
      g.test_framework :rspec,
                       controller_specs: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
