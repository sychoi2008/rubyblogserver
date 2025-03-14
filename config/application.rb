require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rubyserver
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

################
    # config.api_only = false

    # # 세션과 쿠키를 활성화시킨다
    # config.middleware.use ActionDispatch::Cookies
    # #config.middleware.use ActionDispatch::Session::CookieStore, key: '_your_app_session'

    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      # 위 cors.rb랑 같은 설정
    end

# ✅ 쿠키/세션 활성화 추가!
config.middleware.use ActionDispatch::Cookies
config.middleware.use ActionDispatch::Session::CookieStore, key: '_rubyserver_session'

  end
end
