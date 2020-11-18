class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  validates :name, :img, :position, presence: true
  validates :name, uniqueness: { case_sensitive: true }, length: { minimum: 3 }
  validates :img, format: { with: /\A(http)?s?:?(\/\/[^"']*\.(?:png|jpg|jpeg|gif|png|svg))\z/,
                            message: 'invalid image url'}
  validates_associated :appointments
end
