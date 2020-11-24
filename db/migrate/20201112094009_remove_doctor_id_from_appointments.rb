class RemoveDoctorIdFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :doctor_id, :bigint
  end
end
