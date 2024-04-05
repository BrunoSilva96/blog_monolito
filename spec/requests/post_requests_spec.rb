require 'rails_helper'

RSpec.describe '/posts', type: :request do
  let!(:user) { create(:user) }

  describe 'POST /posts' do
    before do
      sign_in(user)
    end

    context 'with valid params' do
      it 'create a new post' do
        post_params = FactoryBot.attributes_for(:post)

        post posts_path, params: { post: { text: post_params[:text], user_id: user.id } }

        expect(response).to redirect_to(posts_path)
        expect(Post.count).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new post' do
        post_params = { text: '' }

        post posts_path, params: { post: { text: post_params[:text], user_id: user.id } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(Post.count).to eq(0)
      end
    end
  end

  describe 'PUT /posts' do
    context 'update post' do
      let!(:user) { create(:user) }
      let!(:post) { create(:post, user:) }

      before do
        sign_in user
      end

      it 'updates post with valid params' do
        put posts_path, params: { post: { text: 'New post text' } }

        expect(response).to redirect_to(posts_path)
        expect(post.reload.text).to eq('New post text')
      end
    end
  end
end
