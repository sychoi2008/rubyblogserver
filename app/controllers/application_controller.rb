class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception

  # respond_to :json

  #protect_from_forgery with: :null_session

  #before_action :authenticate_user! # Devise 인증

  include ActionController::Cookies  # ✅ 쿠키 기능 추가 (세션 쿠키 전달을 위해 필요)



  before_action :authenticate_user!

  respond_to :json
end
