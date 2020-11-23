class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  validates :start_time, :end_time, presence: true
  validates_with DurationValidator,on: :create
  validates_with WorkingHoursValidator, on: :create
  validates_with TimeSlotIntersectionValidator, on: :create
  validates_with AlreadyExistingTimeSlotValidator,on: :create
end
