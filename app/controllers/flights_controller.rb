class FlightsController < ApplicationController
  before_action :require_authentication
  before_action :set_flight, only: %i[show edit update destroy]
  before_action :load_airports, only: %i[new create edit update]

  def index
    @flights = Current.user.flights
      .includes(:departure_airport, :arrival_airport)
      .order(departure_date: :desc, created_at: :desc)
  end

  def show
  end

  def new
    @flight = Current.user.flights.new(departure_date: Date.current)
  end

  def create
    @flight = Current.user.flights.new(flight_params)

    if @flight.save
      redirect_to @flight, notice: "Flight logged."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @flight.update(flight_params)
      redirect_to @flight, notice: "Flight updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flight.destroy!
    redirect_to flights_path, notice: "Flight deleted."
  end

  private

  def set_flight
    @flight = Current.user.flights.find(params[:id])
  end

  def load_airports
    @airports = Airport.order(:iata_code).limit(10)
  end

  def flight_params
    params.require(:flight).permit(
      :departure_airport_id,
      :arrival_airport_id,
      :departure_date,
      :departure_time_local,
      :arrival_time_local,
      :airline_name,
      :airline_iata,
      :flight_number,
      :aircraft_type,
      :cabin_class,
      :seat,
      :distance_miles,
      :duration_minutes,
      :notes
    )
  end
end