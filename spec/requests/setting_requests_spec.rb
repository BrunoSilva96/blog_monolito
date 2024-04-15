require 'rails_helper'

RSpec.describe '/settings', type: :request do
  describe 'PATCH /settings' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    context 'update email or name with valid params' do
      let(:valid_user_params) { { name: 'NewName', current_password: '123456' } }

      it 'updates the User' do
        patch update_user_settings_path, params: { user: valid_user_params }

        expect(response).to have_http_status(:redirect)
        expect(user.reload.name).to eq('NewName')
      end
    end
  end
end
