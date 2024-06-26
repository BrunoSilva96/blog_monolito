require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'POST /users' do
    context 'with valid params' do
      let(:valid_user_params) { FactoryBot.attributes_for(:user) }

      it 'creates a new User' do
        post user_registration_path, params: { user: valid_user_params }

        expect(User.count).to eq(1)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_user_params) { { name: '', email: 'email@email.com', password: '123456' } }

      it 'does not create a new User' do
        post user_registration_path, params: { user: invalid_user_params }

        expect(User.count).to eq(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /users' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    context 'with valid params' do
      let(:valid_user_params) { { name: 'NewName', email: 'new_email@example.com', current_password: '123456' } }

      it 'updates the User' do
        put user_registration_path, params: { user: valid_user_params }

        expect(response).to have_http_status(:redirect)
        expect(user.reload.email).to eq('new_email@example.com')
        expect(user.reload.name).to eq('NewName')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_user_email) { { name: 'NewName', email: '', current_password: '123456' } }

      it 'does not update the User' do
        put user_registration_path, params: { user: invalid_user_email }

        expect { user.reload }.not_to(change { user.email })
        expect(response).to have_http_status(:unprocessable_entity)
      end

      let(:invalid_user_password) { { name: 'NewName', email: 'teste@email.com', current_password: '' } }

      it 'does not update the User' do
        put user_registration_path, params: { user: invalid_user_password }

        expect { user.reload }.not_to(change { user.email })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /users' do
    let!(:user) { create(:user) }

    context 'when user is signed in' do
      before do
        sign_in user
      end

      it 'deletes the User' do
        delete user_registration_path

        expect(response).to have_http_status(:redirect)
        expect(User.exists?(user.id)).to be_falsey
      end
    end
  end
end
