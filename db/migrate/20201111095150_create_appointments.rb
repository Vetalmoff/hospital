class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
