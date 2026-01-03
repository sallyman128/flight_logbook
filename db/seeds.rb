puts "Seeding data..."

# ---- User ----
user =
  User.find_or_create_by!(email_address: "demo@example.com") do |u|
    u.password = "password"
    u.ui_mode = "hotwire"
  end

puts "✓ User created: #{user.email_address}"

# ---- Airports ----
airports_data = [
  {
    iata_code: "DCA",
    icao_code: "KDCA",
    name: "Ronald Reagan Washington National Airport",
    city: "Washington",
    region: "DC",
    country: "US",
    latitude: 38.8512,
    longitude: -77.0402
  },
  {
    iata_code: "IAD",
    icao_code: "KIAD",
    name: "Washington Dulles International Airport",
    city: "Dulles",
    region: "VA",
    country: "US",
    latitude: 38.9531,
    longitude: -77.4565
  },
  {
    iata_code: "JFK",
    icao_code: "KJFK",
    name: "John F. Kennedy International Airport",
    city: "New York",
    region: "NY",
    country: "US",
    latitude: 40.6413,
    longitude: -73.7781
  },
  {
    iata_code: "LAX",
    icao_code: "KLAX",
    name: "Los Angeles International Airport",
    city: "Los Angeles",
    region: "CA",
    country: "US",
    latitude: 33.9416,
    longitude: -118.4085
  },
  {
    iata_code: "ORD",
    icao_code: "KORD",
    name: "O'Hare International Airport",
    city: "Chicago",
    region: "IL",
    country: "US",
    latitude: 41.9742,
    longitude: -87.9073
  }
]

airports = airports_data.map do |attrs|
  Airport.find_or_create_by!(iata_code: attrs[:iata_code]) do |airport|
    airport.assign_attributes(attrs)
  end
end

puts "✓ Airports seeded: #{airports.size}"

# Helper lookup
airport = ->(code) { Airport.find_by!(iata_code: code) }

# ---- Flights ----
flights_data = [
  {
    departure_airport: "DCA",
    arrival_airport: "JFK",
    departure_date: Date.new(2023, 5, 12),
    airline_name: "American Airlines",
    airline_iata: "AA",
    flight_number: "456",
    aircraft_type: "A320",
    cabin_class: "Economy",
    seat: "14A",
    distance_miles: 213,
    duration_minutes: 65,
    notes: "Quick hop to NYC"
  },
  {
    departure_airport: "JFK",
    arrival_airport: "LAX",
    departure_date: Date.new(2023, 5, 15),
    airline_name: "Delta",
    airline_iata: "DL",
    flight_number: "789",
    aircraft_type: "A321neo",
    cabin_class: "Economy",
    seat: "22C",
    distance_miles: 2475,
    duration_minutes: 360,
    notes: "Cross-country flight"
  },
  {
    departure_airport: "LAX",
    arrival_airport: "ORD",
    departure_date: Date.new(2024, 3, 2),
    airline_name: "United",
    airline_iata: "UA",
    flight_number: "1123",
    aircraft_type: "737-900",
    cabin_class: "Economy Plus",
    seat: "9D",
    distance_miles: 1744,
    duration_minutes: 245,
    notes: "Smooth flight, good legroom"
  },
  {
    departure_airport: "ORD",
    arrival_airport: "IAD",
    departure_date: Date.new(2024, 3, 6),
    airline_name: "United",
    airline_iata: "UA",
    flight_number: "834",
    aircraft_type: "A319",
    cabin_class: "Economy",
    seat: "18F",
    distance_miles: 589,
    duration_minutes: 110,
    notes: "Evening arrival"
  }
]

flights_data.each do |attrs|
  Flight.find_or_create_by!(
    user: user,
    departure_airport: airport.call(attrs[:departure_airport]),
    arrival_airport: airport.call(attrs[:arrival_airport]),
    departure_date: attrs[:departure_date],
    airline_iata: attrs[:airline_iata],
    flight_number: attrs[:flight_number]
  ) do |flight|
    flight.assign_attributes(
      attrs.except(:departure_airport, :arrival_airport)
    )
  end
end

puts "✓ Flights seeded: #{user.flights.count}"

puts "Seeding complete ✅"
puts
puts "Login with:"
puts "  email: demo@example.com"
puts "  password: password"