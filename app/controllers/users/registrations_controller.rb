class Users::RegistrationsController < Devise::RegistrationsController
  # 이 파일이 필요한 이유 : 기본 devise controller가 제공되지만 이것은 커스텀 버전
  # 커스텀 컨트롤러가 필요한 이유는, 추가 파라미터를 받기 위해서이다(기존은 이메일과 비밀번호, 비밀번호 확인이 끝)
  # 또한, json으로 리턴하기 위해서 

  respond_to :json # 이 컨트롤러는 json으로만 요청/응답한다
  skip_before_action :authenticate_user!, only: [:create, :new] # 회원가입 시점에는 인증 스킵하기 
  #skip_before_action :verify_authenticity_token, only: [:create] # CSRF 토큰 검사는 생략함 

  def create
    # resource: 지금 가입하려는 User(유저가 보낸 가입하려는 객체)
    build_resource(sign_up_params)  

    if resource.save # 실제 DB에 넣는 과정
      render json: {
        status: { code: 200, message: '회원가입 성공!' },
        data: resource.as_json(only: [:id, :email, :name])
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: '회원가입 실패', errors: resource.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end

 # name 필드를 추가했기 때문에 따로 선언 
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
