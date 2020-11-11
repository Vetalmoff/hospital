class Appointment < ApplicationRecord
  validates :start_time, :end_time, presence: true
end
