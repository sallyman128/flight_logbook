class FlightsController < ApplicationController
  before_action :require_authentication
  before_action :get_flight, only: :show

  def index
    @flights = Current.user.flights.includes(:departure_airport, :arrival_airport).order(departure_date: :desc, created_at: :desc)
  end

  def new
  end

  def show
  end

  private

  def get_flight
    @flight = Flight.find(params[:id])
  end
end
