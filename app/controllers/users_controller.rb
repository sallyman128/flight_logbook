class UsersController < ApplicationController
  before_action :require_authentication

  def update
    if Current.user.update(user_params)
      redirect_back fallback_location: root_path, notice: "Switched to #{Current.user.ui_mode} mode"
    else
      redirect_back fallback_location: root_path, alert: "Invalid UI mode"
    end
  end

  private

  def user_params
    params.require(:user).permit(:ui_mode)
  end
end
