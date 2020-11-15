class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates :name, :img, :position, presence: true
  validates :name, uniqueness: true
end
