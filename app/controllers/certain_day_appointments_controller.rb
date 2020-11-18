class CertainDayAppointmentsController < ApplicationController
  def index
    if params[:doctor_id]
      @appointments = Appointment.order(:start_time)

      time_now = Time.now()
      year = time_now.year
      month = time_now.month
      day = time_now.day

      current_day = Time.new(year, month, day)
      next_day = current_day + 1.day

      @doctor = Doctor.find(params[:doctor_id])
      @doctor_this_day_appointments = @appointments.where(["start_time > ? and start_time < ? and doctor_id = ?", current_day, next_day, params[:doctor_id]])
    end
  end
end
