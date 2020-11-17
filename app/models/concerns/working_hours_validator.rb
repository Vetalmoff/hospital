class WorkingHoursValidator < ActiveModel::Validator

  START_TIME = 9
  END_TIME = 17


  def validate(record)

    if record.start_time.hour < START_TIME
      record.errors[:start_time] << "Start time should be later than #{START_TIME}-00"
    end

    if record.end_time.hour > END_TIME
      record.errors[:end_time] << "Start time should be earlier than #{END_TIME}-00"
    end

  end
end