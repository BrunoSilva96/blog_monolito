class UsersController < ApplicationController
  before_action :load_user, only: %i[update]

  def update
    @user.attributes = user_params
    @user.save!
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
