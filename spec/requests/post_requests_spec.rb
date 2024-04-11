require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'POST /posts' do
    let!(:user) { create(:user) }

    before do
      sign_in(user)
    end

    context 'with valid params' do
      it 'create a new Post' do
        post_params = FactoryBot.attributes_for(:post)

        post posts_path, params: { post: { text: post_params[:text] } }

        expect(response).to redirect_to(posts_path)
        expect(Post.count).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Post' do
        post_params = { text: '' }

        post posts_path, params: { post: { text: post_params[:text], user_id: user.id } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Post.count).to eq(0)
      end
    end
  end

  describe 'PUT /posts' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user:) }

    context 'with valid params' do
      before do
        sign_in user
      end

      it 'updates Post' do
        put posts_path, params: { post: { id: post.id, text: 'New post text' } }

        expect(response).to redirect_to(posts_path)
        expect(post.reload.text).to eq('New post text')
      end
    end

    context 'invalid params' do
      it 'does not update Post' do
        put posts_path, params: { post: { id: post.id, text: nil } }

        expect { post.reload }.not_to(change { post.text })
      end
    end
  end

  describe 'DELETE /posts' do
    let!(:user1) { create(:user) }
    let!(:post1) { create(:post, user: user1) }
    let!(:user2) { create(:user) }
    let!(:post2) { create(:post, user: user2) }

    before do
      sign_in user1
    end

    context 'Delete post' do
      it 'delete Post with success' do
        delete posts_path, params: { post: { id: post1.id } }

        expect(response).to have_http_status(:no_content)
        expect(Post.count).to eq(1)
      end
    end

    context 'when user tries to delete another users post' do
      it 'does not delete the post' do
        delete posts_path, params: { post: { id: post2.id } }

        expect(response).to have_http_status(401)
        expect(Post.count).to eq(2)
      end
    end
  end
end
