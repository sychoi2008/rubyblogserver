class Users::RegistrationsController < Devise::RegistrationsController
  # 이 파일이 필요한 이유 : 기본 devise controller가 제공되지만 이것은 커스텀 버전
  # 커스텀이 필요한 이유는, 추가 파라미터를 받기 위해서이다(기존은 이메일과 비밀번호, 비밀번호 확인이 끝)
  # 또한, json으로 리턴하기 위해서 

  respond_to :json # 이 컨트롤러는 json으로만 요청/응답한다
  skip_before_action :authenticate_user!, only: [:create, :new]
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: {
        status: { code: 200, message: '회원가입 성공!' },
        data: resource
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: '회원가입 실패', errors: resource.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end

  # def create
  #   logger.debug "받은 파라미터: #{params.inspect}"
  #   user = User.new(sign_up_params)
  
  #   if user.save
  #     logger.debug "저장 성공!"
  #     render json: { user: user }, status: :created
  #   else
  #     logger.debug "저장 실패: #{user.errors.full_messages}"
  #     render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
  


  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
