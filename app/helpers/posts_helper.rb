module PostsHelper
  def user_post_delete?(post, current_user)
    user_signed_in? && current_user == post.user
  end
end
