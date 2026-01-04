class AirportsController < ApplicationController
  before_action :require_authentication

  def index
    @airports = Airport.order(:icao_code).page(params[:page]).per(10)
  end
end
