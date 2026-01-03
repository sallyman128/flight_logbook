class User < ApplicationRecord
  UI_MODES = %w[hotwire react].freeze

  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :ui_mode, inclusion: { in: UI_MODES }
end
