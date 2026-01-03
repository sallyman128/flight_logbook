class ReactUiController < ApplicationController
  def show
    if Current.user&.ui_mode == "hotwire"
      redirect_to root_path
    end
  end
end
