class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.email_regex

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: Settings.max_name }
  validates :email, presence: true, length: { maximum: Settings.max_email },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: Settings.min_password }

  has_secure_password
end
