class PostsController < ApplicationController

  # before_action: 컨트롤러 액션이 실행되기 전에 특정 메서드를 호출하는 명령어
  # 이것 덕분에 current_user이 생성됨(클라이언트가 넘겨준 쿠키로 생성하는 것)
  # JWT는 토큰을 검증하기 위한 별도의 메서드가 필요하지만 세션은 그럴 필요가 없음 
  before_action :authenticate_user!

  # 게시글 작성
  def create
    post = current_user.posts.new(post_params) # 유저가 작성한 새로운 글을 연결함 
  
    if post.save # DB에 저장 
      render json: { message: '게시글 생성 완료!', post: post }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #목록갖고 오기
  def index
    # current_user = 현재 로그인한 사용자 객체임(Devise가 제공하는 기능. 현재 로그인한 사용자의 정보를 자동으로 반환)
    posts = current_user.posts.includes(:tag) # N+1문제로 인해서 includes를 사용 
    render json: posts.as_json(include: { tag: { only: [:id, :name] } })
  end

  def show
    post = current_user.posts.find(params[:id]) # uri에서 가져온 동적 파라미터 
    render json: post.as_json(include: { tag: { only: [:id, :name] } })
  end

  def update
    post = current_user.posts.find(params[:id]) # 내 글 중 하나를 찾음
    if post.update(post_params) # 업데이트 시도 
      render json: { message: '게시글 수정 성공', post: post }
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    if post.destroy
      render json: { message: '게시글 삭제 완료!' }, status: :ok
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  private
  # strong parameter : 레일즈가 허용하는 값만 지정하는 것. 나머지는 무시하거나 에러 발생 
  def post_params
    params.require(:post).permit(:title, :content, :tag_id)
  end
end
