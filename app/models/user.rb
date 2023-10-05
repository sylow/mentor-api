class User < ApplicationRecord
  has_secure_password

  has_many :records

  validates :username, :email, uniqueness: true
end
