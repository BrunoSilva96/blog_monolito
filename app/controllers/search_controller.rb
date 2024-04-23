class SearchController < ApplicationController
  def search_tags
    @tags = Tag.where('lower(tag_text) LIKE ?', "%#{params[:term].downcase}%")
               .page(params[:page]).per(3)
    @posts = Post.all
  end
end
