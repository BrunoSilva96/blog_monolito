require 'rails_helper'

RSpec.describe '/comments', type: :request do
  let!(:user) { create(:user) }
  let!(:post_for_comment) { create(:post, user:) }

  describe 'POST /comments' do
    before do
      sign_in user
    end

    context 'with valid params' do
      it 'create a new Comment' do
        comment_params = FactoryBot.attributes_for(:comment)
        post comments_path, params: { comment: { post_id: post_for_comment.id, text: comment_params[:text] } }

        expect(Comment.count).to eq(1)
      end

      it 'update a Comment' do
        comment = create(:comment, user:, post: post_for_comment)

        put comment_path(comment), params: { comment: { post_id: post_for_comment.id, text: 'New text' } }

        expect(response).to redirect_to(posts_path)
        expect(comment.reload.text).to eq('New text')
      end
    end

    context 'with invalid params' do
      it 'does not create a new Comment' do
        post comments_path, params: { comment: { post_id: post_for_comment.id, text: nil } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Comment.count).to eq(0)
      end
    end
  end

  describe 'DELETE /comments' do
    let!(:another_user) { create(:user) }
    let!(:post) { create(:post, user:) }
    let!(:comment) { create(:comment, post:, user:) }

    context 'delete Comment' do
      it 'delete Comment with success' do
        sign_in user

        delete comment_path(comment), params: { comment: { id: comment.id } }

        expect(response).to have_http_status(:no_content)
        expect(Comment.count).to eq(0)
      end
    end

    context 'when user tries to delete another users comment' do
      it 'does not delete Comment' do
        sign_in another_user

        delete comment_path(comment), params: { comment: { id: comment.id } }

        expect(response).to have_http_status(:no_content)
        expect(Comment.count).to eq(1)
      end
    end
  end
end
