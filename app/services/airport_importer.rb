require "csv"
require "open-uri"

class AirportImporter
  US_AIRPORTS_URL = "https://ourairports.com/countries/US/airports.csv"

  def self.import!
    csv_data = URI.open(US_AIRPORTS_URL).read
    rows = CSV.parse(csv_data, headers: true)

    now = Time.current
    airports = []

    rows.each do |row|
      iata = row["iata_code"].to_s.strip
      next if iata.blank? # REQUIRED by your schema

      airports << {
        iata_code: iata,
        icao_code: row["icao_code"].presence,
        name: row["name"].presence || iata,
        city: row["municipality"].presence,
        region: row["iso_region"].presence,
        country: row["iso_country"].presence || "US",
        latitude: row["latitude_deg"],
        longitude: row["longitude_deg"],
        elevation_ft: row["elevation_ft"].presence,
        created_at: now,
        updated_at: now
      }
    end

    Airport.upsert_all(airports, unique_by: :index_airports_on_iata_code)
  end
end
