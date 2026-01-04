puts "Seeding data..."

# ---- User ----
user =
  User.find_or_create_by!(email_address: "demo@example.com") do |u|
    u.password = "password"
    u.ui_mode = "hotwire"
  end

puts "✓ User created: #{user.email_address}"

puts "Seeding complete ✅"
puts
puts "Login with:"
puts "  email: demo@example.com"
puts "  password: password"