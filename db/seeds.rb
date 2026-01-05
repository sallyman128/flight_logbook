puts "Seeding data..."

# ---- User ----
user =
  User.find_or_create_by!(email_address: "demo@example.com") do |u|
    u.password = "password"
    u.ui_mode = "hotwire"
  end

puts "✓ User created: #{user.email_address}"

unless Airport.count > 0
  puts "Fetching aiports"
  AirportImporter.import!
  puts "Fetched #{Airport.count} airports"
end

iad = Airport.find_by(iata_code: "IAD")
ord = Airport.find_by(iata_code: "ORD")
sea = Airport.find_by(iata_code: "SEA")
lax = Airport.find_by(iata_code: "LAX")
user.flights.create(departure_date: Date.today, departure_airport: iad, arrival_airport: sea)
user.flights.create(departure_date: Date.today, departure_airport: sea, arrival_airport: ord)
user.flights.create(departure_date: Date.today - 1.year, departure_airport: ord, arrival_airport: lax)
user.flights.create(departure_date: Date.today - 2.years, departure_airport: lax, arrival_airport: sea)

puts "Seeding complete ✅"
puts
puts "Login with:"
puts "  email: demo@example.com"
puts "  password: password"
