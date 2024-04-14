class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def password; end

  def update_user
    if !current_password_params[:current_password].empty? && current_user.valid_password?(current_password_params[:current_password])
      if current_user.update(user_params)
        redirect_to settings_path, notice: 'Seus dados foram atualizados com sucesso!'
      else
        render :index
      end
    else
      redirect_to settings_path, notice: 'Você precisa informar sua senha atual para trocar de senha'
    end
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

  def user_params
    params.require(:user).permit(:name, :phone, :avatar)
  end

  def current_password_params
    params.require(:user).permit(:current_password)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
