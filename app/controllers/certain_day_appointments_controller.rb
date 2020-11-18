class CertainDayAppointmentsController < ApplicationController
  def index
    @appointments = Appointment.order(:start_time)

    p '=============='
    p params[:user_id]
    year = params["start_time(1i)"]
    month = params["start_time(2i)"]
    day = params["start_time(3i)"]



    current_day = Time.new(year, month, day)
    next_day = current_day + 1.day

    @doctor = Doctor.find(params[:doctor_id])
    @doctor_this_day_appointments = @appointments.where(["start_time > ? and start_time < ? and doctor_id = ?", current_day, next_day, params[:doctor_id]])
    @your_appointment = Appointment.where(["start_time > ? and start_time < ? and doctor_id = ? and user_id = ?", current_day, next_day, params[:doctor_id], params[:user_id]]).last

  end
end
