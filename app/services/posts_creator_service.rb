class PostsCreatorService
  def initialize(posts_params)
    @posts_params = posts_params
  end

  def call
    @posts_params.each do |post_params|
      CreatePostJob.perform_later(post_params[:text], post_params[:user_id])
    end
  end
end
