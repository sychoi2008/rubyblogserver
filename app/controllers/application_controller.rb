# API 전용 컨트롤러 선언
# 뷰 렌더링 X, 쿠키 세션 CSRF 기본으로 비활성화 
class ApplicationController < ActionController::API

  include ActionController::Cookies # 세션 방식이라 쿠키 필요(브라우저에 넘겨줄 때에도 받을 때에도)

  before_action :authenticate_user! # 기본적으로 모든 컨트롤러는 로그인 된 유저만 가능

  respond_to :json # 모든 응답은 JSON으로 
end
