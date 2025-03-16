class PostsController < ApplicationController

  # 이것 덕분에 warden으로 인증된 사용자를 자동으로 current_user에 연결해줌 
  before_action :authenticate_user!
  # 포스팅 하기
  def create
    post = current_user.posts.new(post_params)
  
    if post.save
      render json: { message: '게시글 생성 완료!', post: post }, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #목록갖고 오기
  def index
    # current_user = 현재 로그인한 사용자 객체임(Devise가 제공하는 기능. 현재 로그인한 사용자의 정보를 자동으로 반환)
    # 
    posts = current_user.posts.includes(:tag)
    render json: posts.as_json(include: { tag: { only: [:id, :name] } })
  end

  def show
    post = current_user.posts.find(params[:id])
    render json: post.as_json(include: { tag: { only: [:id, :name] } })
  end

  def update
    post = current_user.posts.find(params[:id])
    if post.update(post_params)
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

  # strong parameter (허용할 값만 필터링해서 받는다)
  def post_params
    params.require(:post).permit(:title, :content, :tag_id)
  end
end
