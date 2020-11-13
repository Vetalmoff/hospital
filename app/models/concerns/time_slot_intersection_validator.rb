class TimeSlotIntersectionValidator < ActiveModel::Validator


  def validate(record)
    day = record.start_time.day
    month = record.start_time.month
    year = record.start_time.year

    search_day = Time.new(year, month, day)
    next_day = Time.new(year, month, day + 1)

    @list_of_time_slots = Appointment.where(["start_time > ? and start_time < ?", search_day, next_day])

    if @list_of_time_slots.length > 0
      @list_of_time_slots.each do |item|
        if  !(record.start_time >= item.end_time || record.end_time <= item.start_time)
          # puts "We cant insert #{time_slot.start_time.strftime "%H:%M"} - #{time_slot.end_time.strftime "%H:%M"}, because your visit cross other visites"
          record.errors[:start_time] << "We cant insert #{record.start_time.strftime "%H:%M"} - #{record.end_time.strftime "%H:%M"}, because your visit cross other visites"
        end
      end
    end
  end
end
