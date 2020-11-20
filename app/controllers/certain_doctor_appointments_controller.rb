class CertainDoctorAppointmentsController < ApplicationController
  def index
    puts '111111========'
    puts params[:id]
    @doctor_appointments = Appointment.where(['doctor_id = ?', params[:id]]).order(start_time: :desc)
  end
end
