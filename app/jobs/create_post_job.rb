class CreatePostJob < ApplicationJob
  queue_as :default

  def perform(text, user_id)
    Post.create!(text:, user_id:)
  end
end
