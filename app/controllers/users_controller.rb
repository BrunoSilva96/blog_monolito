class UsersController < ApplicationController
  before_action :load_user, only: %i[update]

  def update
    @user.attributes = user_params
    @user.save!
  end

  def update_password
    if !current_password_params[:current_password].empty? && current_user.valid_password?(current_password_params[:current_password])
      if current_user.update(password_params)
        bypass_sign_in(current_user)
        redirect_to password_settings_path, notice: 'Sua senha foi atualizados com sucesso!'
      else
        render password_settings_path
      end
    else
      redirect_to password_settings_path, notice: 'Você precisa informar sua senha atual para trocar de senha'
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
