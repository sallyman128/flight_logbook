class User < ApplicationRecord
  UI_MODES = %w[hotwire react].freeze

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :flights

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :ui_mode, inclusion: { in: UI_MODES }

  def react_ui?
    ui_mode == "react"
  end

  def hotwire_ui?
    ui_mode == "hotwire"
  end
end
