class PostsController < ApplicationController
  # 포스팅 하기
  def create_table
    @Post = Post.new(post_params)

    if @Post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  # strong parameter (허용할 값만 필터링해서 받는다)
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :tag_id)
  end
end
