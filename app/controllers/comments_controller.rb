class CommentsController < ApplicationController
  before_action :load_comment, only: %i[update destroy edit]

  def index
    @comments = Comment.all
  end

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user&.id))

    if @comment.save
      redirect_to @comment.post
    else
      redirect_to @comment.post, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @comment.update(comment_params)

    redirect_to posts_path if @comment.save!
  end

  def destroy
    @comment.destroy!
  end

  private

  def load_comment
    @comment = Comment.find_by_id(params[:id])
    head :unauthorized if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
