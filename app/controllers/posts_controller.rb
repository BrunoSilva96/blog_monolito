class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: %i[update destroy edit]
  before_action :load_tags, only: %i[edit]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @all_tags = Tag.all

    @posts = Post.includes(:comments).order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    if params[:posts].present?
      posts_params = params[:posts].map do |post_param|
        post_param.permit(:text).merge(user_id: current_user.id)
      end
      PostsCreatorService.new(posts_params).call
      redirect_to posts_path, notice: 'Posts estão sendo criados!'
    else
      @post = Post.new(post_params.merge(user_id: current_user.id))
      if @post.save
        redirect_to posts_path
      else
        redirect_to posts_path, status: :unprocessable_entity
      end
    end
  end

  def edit; end

  def update
    @post.update(post_params_update)

    redirect_to posts_path if @post.save!
  end

  def destroy
    @post.destroy!

    redirect_to posts_path
  end

  private

  def load_tags
    @tags = Tag.all.map { |tag| [tag.tag_text, tag.id] }
  end

  def load_post
    @post = current_user.posts.find_by(id: params[:id])

    head :unauthorized if @post.nil?
  end

  def post_params_update
    params.require(:post).permit(:text, tag_ids: [])
  end

  def post_params
    params.permit(:text, :tag_ids)
  end
end
