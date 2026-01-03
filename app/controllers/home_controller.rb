class HomeController < ApplicationController
  # before_action :require_authentication

  def show
    if Current.user&.ui_mode == "react"
      redirect_to "/app"
    end
  end
end
