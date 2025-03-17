Rails.application.routes.draw do
  devise_for :users, # Devise가 User 모델을 기반으로 회원가입, 로그인, 로그아웃 URI를 자동으로 만들어줌
  defaults: { format: :json }, # 모든 요청에 대한 처리가 JSON으로 응답한다 
  controllers: { # Devise의 기본 컨트롤러를 커스터마이징한 것
    registrations: 'users/registrations', # 회원가입용 내가 만든 컨트롤러
    sessions: 'users/sessions' # 로그인용 내가 만든 컨트롤러 
  }, skip: [:omniauth_callbacks] # 소셜 로그인은 안 쓸거임! 관련 경로는 만들지마!

  get "up" => "rails/health#show", as: :rails_health_check # 서버가 잘 돌아가는지 체크하는 용도

  resources :posts #posts에 대한 라우트 자동 생성
  resources :tags, only: [:index] # get /tags만 지원하는 라우트생성! -> 태그 리스트만 반환하는 API 
end
