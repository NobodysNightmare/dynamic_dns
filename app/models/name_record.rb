# frozen_string_literal: true

class NameRecord < ApplicationRecord
  def authentic?(id, secret)
    return false unless client_id == id

    client_secret == secret
  end

  def client_secret
    @client_secret ||= BCrypt::Password.new(client_secret_hash)
  end

  def client_secret=(value)
    self.client_secret_hash = value
    @client_secret = value
  end

  def client_secret_hash=(_value)
    @client_secret = nil
    super
  end
end
