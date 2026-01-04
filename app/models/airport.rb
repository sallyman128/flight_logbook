class Airport < ApplicationRecord
  has_many :departing_flights, class_name: "Flight", foreign_key: :departure_airport_id, dependent: :restrict_with_error
  has_many :arriving_flights,  class_name: "Flight", foreign_key: :arrival_airport_id,   dependent: :restrict_with_error

  scope :search, ->(query) do
    q = query.to_s.strip
    next all if q.blank?

    where(
      "iata_code ILIKE :q OR name ILIKE :q OR city ILIKE :q OR region ILIKE :q",
      q: "%#{sanitize_sql_like(q)}%"
    )
  end
end
