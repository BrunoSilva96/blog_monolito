class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: %i[update destroy edit]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @posts = Post.includes(:comments).order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    else
      redirect_to posts_path, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @post.update(post_params_update)

    redirect_to posts_path if @post.save!
  end

  def destroy
    @post.destroy!
  end

  private

  def load_post
    @post = current_user.posts.find_by(id: params[:id])

    head :unauthorized if @post.nil?
  end

  def post_params_update
    params.require(:post).permit(:text)
  end

  def post_params
    params.permit(:text, :tag_ids)
  end
end
