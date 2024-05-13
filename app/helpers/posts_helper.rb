module PostsHelper
  def user_post_delete?(post, current_user)
    user_signed_in? && current_user == post.user
  end

  def user_comment?(post, comment, current_user)
    user_signed_in? && current_user == comment.user || current_user == post.user
  end
end
