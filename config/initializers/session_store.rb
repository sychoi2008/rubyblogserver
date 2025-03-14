Rails.application.config.session_store :cookie_store,
  key: '_rubyserver_session',     # 세션 쿠키 이름 (브라우저에서 보일 이름)
  expire_after: 1.hour,         # 유효 기간
  secure: false,                  # 로컬에서는 반드시 false!
  same_site: :lax                 # 보통 :lax or :strict
