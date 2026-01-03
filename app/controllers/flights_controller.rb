class FlightsController < ApplicationController
  before_action :require_authentication

  def index
    @flights = Current.user.flights.includes(:departure_airport, :arrival_airport).order(departure_date: :desc, created_at: :desc)
  end

  def new
  end
end
