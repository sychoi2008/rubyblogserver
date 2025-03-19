class Users::SessionsController < Devise::SessionsController # 로그인용 컨트롤러
  respond_to :json # 모든 요청에 대한 응답은 JSON
  skip_before_action :authenticate_user!, only: [:create, :new] # 로그인 컨트롤러에는 인증 필터 적용 안함!

  #로그인 처리 => 세션 생성
  def create
    # 유저가 보낸 이메일 + 비밀번호를 사용해서 테이블을 조회 -> 인증 성공하면 user 객체 반환, 실패하면 nil 
    # 단순히 인증만
    user = warden.authenticate(auth_options)

    if user # 인증 완료되면 
      sign_in(resource_name, user) # 세션 생성, 쿠키 발급, 

      render json: {
        message: "로그인 성공",
        user: {
          id: user.id,
          email: user.email,
          name: user.name 
        }
      }, status: :ok
    else
      render json: { message: "이메일이나 비밀번호가 올바르지 않습니다." }, status: :unauthorized
    end
  end

  # 로그아웃 처리
  def destroy
    sign_out(resource_name) # 세션에서 사용자 정보 삭제해줌 
    reset_session # 레일즈 세션 초기화 

    request.session_options[:skip] = true

    # 빈 깡통 쿠키 전송
    response.delete_cookie('_rubyserver_session', {
      path: '/',               # path를 기존과 같게
      domain: 'localhost',     # 도메인 맞추기 (필요시)
      same_site: :lax,         # 기존 옵션과 동일하게
      secure: false            # secure가 false면 여기도 맞춰줘야 함!
    })

    render json: { message: '로그아웃 성공' }, status: :ok and return
  end
  

  # resource_name : 자동으로 인식하는 모델 이름(여기서는 User)
  def auth_options
    { scope: resource_name }
  end
end
