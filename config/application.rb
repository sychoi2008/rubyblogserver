require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
# 이메일 보낼 거면 사용
# require "action_mailer/railtie"
# require "sprockets/railtie" 

Bundler.require(*Rails.groups)

module Rubyserver
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))

    # API 서버 최적화
    config.api_only = true

    # 세션/쿠키 미들웨어 활성화 (API 서버지만 세션 로그인 때문에 필요)
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_rubyserver_session'

    # CORS 설정 (여기 구현하면 OK)
    config.middleware.insert_before 0, Rack::Cors do
      # cors 설정 예시
      allow do
        origins 'http://localhost:5173/'  # 프론트 주소로 제한하는 게 보안상 안전함!
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true  # 쿠키 사용하면 필수!!
      end
    end
  end
end
