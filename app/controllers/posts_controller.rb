class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: %i[update destroy]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    else
      redirect_to posts_path, status: :unprocessable_entity

    end
  end

  def update
    @post.update(post_params)

    redirect_to posts_path if @post.save!
  end

  def destroy
    if @post.nil?
      head :unauthorized
    else
      @post.destroy!
    end
  end

  private

  def load_post
    @post = current_user.posts.find_by(id: params[:post][:id])
  end

  def post_params
    params.require(:post).permit(:text)
  end
end
