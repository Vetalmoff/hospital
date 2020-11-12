class User < ApplicationRecord
  # has_many :appointments
  # has_many :doctors, through: :appointments
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
end
