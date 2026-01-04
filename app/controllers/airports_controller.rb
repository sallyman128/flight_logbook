class AirportsController < ApplicationController
  before_action :require_authentication

  def index
    @airport_search_query = params[:airport_search_query].to_s
    @airports = Airport.search(@airport_search_query).order(:iata_code).page(params[:page]).per(10)
  end
end
