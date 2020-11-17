class TimeSlotIntersectionValidator < ActiveModel::Validator

  START_TIME = WorkingHoursValidator::START_TIME
  END_TIME = WorkingHoursValidator::END_TIME

  def validate(record)
    day = record.start_time.day
    month = record.start_time.month
    year = record.start_time.year

    search_day = Time.new(year, month, day)
    next_day = Time.new(year, month, day + 1)

    @list_of_time_slots = Appointment.where(["start_time > ? and start_time < ? and doctor_id = ?", search_day, next_day, record.doctor_id])

    if @list_of_time_slots.length > 0
      @list_of_time_slots.each do |item|
        if  !(record.start_time >= item.end_time || record.end_time <= item.start_time)
          find_all_free_time_slots(record, day, month, year)
          find_all_the_same_duration_time_slots(record)
          find_recommended_time_slots(record)
          record.errors[:base] << "We cant insert #{record.start_time.strftime "%H:%M"} - #{record.end_time.strftime "%H:%M"}, because your visit cross other visites!
                                            Free nearest hours you can get are :
                                                #{ @recommended_time_slots.map { |item| "#{item[:start_time].strftime "%H:%M"} - #{item[:end_time].strftime "%H:%M"}" } }"
          return
        end
      end
    end

  end

  def find_all_free_time_slots(time_slot, day, month, year)

    first_time = Time.new(year, month, day, START_TIME)
    end_time = Time.new(year, month, day, END_TIME)

    if first_time != @list_of_time_slots[0].start_time
      first_free_time_slot = {start_time: first_time, end_time: @list_of_time_slots[0].start_time}
      @list_free_time_slots = [first_free_time_slot]
    else
      @list_free_time_slots = []
    end

    i = 0
    while (i < @list_of_time_slots.length - 1)
      if @list_of_time_slots[i].end_time != @list_of_time_slots[i+1].start_time
        @list_free_time_slots.push({start_time: @list_of_time_slots[i].end_time, end_time: @list_of_time_slots[i+1].start_time})
      end
      i += 1
    end

    if end_time != @list_of_time_slots[-1].end_time
      last_free_time_slot = {start_time: @list_of_time_slots[-1].end_time, end_time: end_time}
      @list_free_time_slots.push(last_free_time_slot)
    end
  end

  def find_all_the_same_duration_time_slots(time_slot)
    duration = time_slot.end_time -  time_slot.start_time
    p duration
    @the_same_duration_timeslots = []
    puts @list_free_time_slots
    @list_free_time_slots.each do |item|
      if duration <= (item[:end_time] - item[:start_time])
        @the_same_duration_timeslots.push(item)
      end
    end
  end

  def find_recommended_time_slots(time_slot)

    @recommended_time_slots =[]
    left_time_slots = []
    right_time_slots = []

    @the_same_duration_timeslots.each  do |item|
      if  item[:end_time] <= time_slot.end_time
        left_time_slots.push(item)
      end
      if item[:start_time] >= time_slot.start_time
        right_time_slots.push(item)
      end
    end

    if  left_time_slots.length > 0
      @recommended_time_slots.push(left_time_slots[-1])
    end

    if right_time_slots.length > 0
      @recommended_time_slots.push(right_time_slots[0])
    end
  end

end
