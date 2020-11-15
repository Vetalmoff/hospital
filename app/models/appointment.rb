class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  validates :start_time, :end_time, presence: true
  validates_with DurationValidator
  validates_with WorkingHoursValidator
  validates_with TimeSlotIntersectionValidator
end
