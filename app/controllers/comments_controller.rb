class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user&.id))

    if @comment.save
      redirect_to comments_path
    else
      redirect_to comments_path, status: :unprocessable_entity
    end
  end

  def update
    @comment.update(comment_params)

    redirect_to comments_path if @comment.save!
  end

  def destroy
    @comment.destroy!
  end

  private

  def load_comment
    @comment = current_user.comments.find_by(id: params[:comment][:id])
    head :unauthorized if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
