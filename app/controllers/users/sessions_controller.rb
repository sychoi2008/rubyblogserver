class Users::SessionsController < Devise::SessionsController
  respond_to :json
  #skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  skip_before_action :authenticate_user!, only: [:create, :new]

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

  def destroy
    sign_out(resource_name)
    reset_session

    request.session_options[:skip] = true

    response.delete_cookie('_rubyserver_session', {
      path: '/',               # path를 기존과 같게
      domain: 'localhost',     # 도메인 맞추기 (필요시)
      same_site: :lax,         # 기존 옵션과 동일하게
      secure: false            # secure가 false면 여기도 맞춰줘야 함!
    })

    render json: { message: '로그아웃 성공' }, status: :ok and return
  end
  

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
