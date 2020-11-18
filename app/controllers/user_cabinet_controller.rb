class UserCabinetController < ApplicationController
  def past_appointments
    @past_appointments = Appointment.where(["user_id = ? and start_time < ?", session[:user_id], Time.now()])
  end

  def future_appointments
    @future_appointments = Appointment.where(["user_id = ? and start_time > ?", session[:user_id], Time.now()])
  end

  def index

  end

  def account

  end
end
