class HomeController < ApplicationController
  # before_action :require_authentication

  def show
    if Current.user.hotwire_ui?
      @map_flights = Current.user.flights.includes(:departure_airport, :arrival_airport).map do |f|
        next if f.departure_airport.nil? || f.arrival_airport.nil?

        {
          id: f.id,
          departure_date: f.departure_date&.to_s,
          year: f.departure_date&.year,
          departure: {
            code: f.departure_airport.iata_code,
            name: f.departure_airport.name,
            lat: f.departure_airport.latitude.to_f,
            lng: f.departure_airport.longitude.to_f
          },
          arrival: {
            code: f.arrival_airport.iata_code,
            name: f.arrival_airport.name,
            lat: f.arrival_airport.latitude.to_f,
            lng: f.arrival_airport.longitude.to_f
          }
        }
      end.compact

      render Current.user.ui_mode
    end
  end
end
