class User < ApplicationRecord
  const = Rails.application.config_for(:settings)
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: const["name_length_max"]}
  validates :email, presence: true,
            length: {maximum: const["email_length_max"]},
    format: {with: Regexp.new(const["valid_email_regex"], Regexp::IGNORECASE)},
            uniqueness: true

  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  private

  def downcase_email
    email.downcase!
  end
end
