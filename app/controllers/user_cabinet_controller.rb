class UserCabinetController < ApplicationController
  def past_appointments
    @past_appointments = Appointment.where(["user_id = ? and start_time < ?", session[:user_id], Time.now()]).order(start_time: :desc)
  end

  def future_appointments
    @future_appointments = Appointment.where(["user_id = ? and start_time > ?", session[:user_id], Time.now()]).order(start_time: :asc)
  end

  def index

  end
end
