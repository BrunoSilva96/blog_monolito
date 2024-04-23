class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_tag, only: %i[show update destroy]

  def index
    @tags = Tag.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show; end

  def new
    @tags = Tag.order(created_at: :desc).page(params[:page]).per(10)
    @tag = Tag.new
  end

  def edit; end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path
    else
      redirect_to tags_path, status: :unprocessable_entity
    end
  end

  def update
    @tag.update(tag_params)

    redirect_to tags_path if @tag.save!
  end

  def destroy
    @tag.destroy
  end

  private

  def load_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:tag_text)
  end
end
