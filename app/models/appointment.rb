class Appointment < ApplicationRecord
  # belongs_to :doctor
  # belongs_to :user
  validates :start_time, :end_time, presence: true
end
