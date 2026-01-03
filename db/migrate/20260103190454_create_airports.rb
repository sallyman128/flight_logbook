class CreateAirports < ActiveRecord::Migration[8.0]
  def change
    create_table :airports do |t|
      t.string :iata_code, null: false
      t.string :icao_code
      t.string :name, null: false
      t.string :city
      t.string :region
      t.string :country, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.integer :elevation_ft

      t.timestamps
    end

    add_index :airports, :iata_code, unique: true
    add_index :airports, :icao_code, unique: true
    add_index :airports, [ :latitude, :longitude ]
  end
end
