class CreateFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :flights do |t|
      t.references :user, null: false, foreign_key: true
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }
      t.references :arrival_airport, null: false, foreign_key: { to_table: :airports }
      t.date :departure_date, null: false
      t.time :departure_time_local
      t.time :arrival_time_local
      t.string :airline_name
      t.string :airline_iata
      t.string :flight_number
      t.string :aircraft_type
      t.string :cabin_class
      t.string :seat
      t.integer :distance_miles
      t.integer :duration_minutes
      t.text :notes

      t.timestamps
    end

    add_index :flights, :departure_date
    add_index :flights, [ :user_id, :departure_date ]
    add_index :flights, [ :user_id, :departure_airport_id ]
    add_index :flights, [ :user_id, :arrival_airport_id ]
  end
end
