# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_01_03_190717) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string "iata_code", null: false
    t.string "icao_code"
    t.string "name", null: false
    t.string "city"
    t.string "region"
    t.string "country", null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.integer "elevation_ft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iata_code"], name: "index_airports_on_iata_code", unique: true
    t.index ["icao_code"], name: "index_airports_on_icao_code", unique: true
    t.index ["latitude", "longitude"], name: "index_airports_on_latitude_and_longitude"
  end

  create_table "flights", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "departure_airport_id", null: false
    t.bigint "arrival_airport_id", null: false
    t.date "departure_date", null: false
    t.time "departure_time_local"
    t.time "arrival_time_local"
    t.string "airline_name"
    t.string "airline_iata"
    t.string "flight_number"
    t.string "aircraft_type"
    t.string "cabin_class"
    t.string "seat"
    t.integer "distance_miles"
    t.integer "duration_minutes"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arrival_airport_id"], name: "index_flights_on_arrival_airport_id"
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
    t.index ["departure_date"], name: "index_flights_on_departure_date"
    t.index ["user_id", "arrival_airport_id"], name: "index_flights_on_user_id_and_arrival_airport_id"
    t.index ["user_id", "departure_airport_id"], name: "index_flights_on_user_id_and_departure_airport_id"
    t.index ["user_id", "departure_date"], name: "index_flights_on_user_id_and_departure_date"
    t.index ["user_id"], name: "index_flights_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ui_mode", default: "hotwire", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["ui_mode"], name: "index_users_on_ui_mode"
  end

  add_foreign_key "flights", "airports", column: "arrival_airport_id"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "flights", "users"
  add_foreign_key "sessions", "users"
end
