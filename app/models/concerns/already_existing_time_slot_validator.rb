class AlreadyExistingTimeSlotValidator < ActiveModel::Validator
  def validate(record)
    day = record.start_time.day
    month = record.start_time.month
    year = record.start_time.year

    search_day = Time.new(year, month, day)
    next_day = Time.new(year, month, day + 1)

    if record.id
      @list_of_time_slots = Appointment.where(["start_time > ? and start_time < ? and user_id = ? and id != ?",
                                               search_day,
                                               next_day,
                                               record.user_id,
                                               record.id
                                              ])
                                       .order(:start_time)
    else
      @list_of_time_slots = Appointment.where(["start_time > ? and start_time < ? and user_id = ?",
                                               search_day,
                                               next_day,
                                               record.user_id])
                                       .order(:start_time)

    end

    if @list_of_time_slots.length > 0
      @list_of_time_slots.each do |item|
        if  !(record.start_time >= item.end_time || record.end_time <= item.start_time)
          record.errors[:base] << "We cant insert #{record.start_time.strftime "%H:%M"} - #{record.end_time.strftime "%H:%M"}, because your already have another appointment to doctor #{item.doctor.name} on this time"
          return
        end
      end
    end
  end
end

