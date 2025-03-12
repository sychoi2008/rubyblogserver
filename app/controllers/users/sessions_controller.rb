class Users::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # 인증 시도! 
    user = warden.authenticate(auth_options)

    if user
      sign_in(resource_name, user)

      render json: {
        message: "로그인 성공",
        user: {
          id: user.id,
          email: user.email,
          name: user.name # 필요에 따라 수정!
        }
      }, status: :ok
    else
      render json: { message: "이메일이나 비밀번호가 올바르지 않습니다." }, status: :unauthorized
    end
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
