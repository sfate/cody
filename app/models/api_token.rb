require 'securerandom'

class ApiToken < ActiveRecord::Base
  attr_reader :token

  validates :token_id, uniqueness: true, presence: true

  validate do |record|
    record.errors.add(:token, :blank) unless record.token_digest.present?
  end

  def token=(unecrypted_token)
    if unecrypted_token.nil?
      self.token_digest = nil
    else
      @token = unecrypted_token
      self.token_digest = BCrypt::Password.create(unecrypted_token)
    end
  end

  def self.make!
    new_token_id = SecureRandom.uuid
    new_token = SecureRandom.hex

    new_obj = self.new
    new_obj.token_id = new_token_id
    new_obj.token = new_token

    new_obj.save!

    new_obj
  end

  def authenticate(unecrypted_token)
    BCrypt::Password.new(self.token_digest) == unecrypted_token && self
  end
end
