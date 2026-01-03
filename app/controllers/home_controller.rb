class HomeController < ApplicationController
  # before_action :require_authentication

  def show
    render "#{Current.user.ui_mode}"
  end
end
