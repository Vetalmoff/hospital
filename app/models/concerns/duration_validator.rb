
class DurationValidator < ActiveModel::Validator

  LIMIT_DURATION = 30
  MULTIPLIER = 5

  def validate(record)

    if (record.end_time - record.start_time) > (LIMIT_DURATION * 60)
      record.errors[:start_time] << "Duration should be less than #{LIMIT_DURATION} minutes"
    end

    if (record.end_time - record.start_time) % (MULTIPLIER * 60) != 0
      record.errors[:start_time] << "Time should be divided by #{MULTIPLIER} minutes"
    end

    if (record.end_time - record.start_time) <= 0
      record.errors[:start_time] << 'End time should be graiter than start time'
    end

  end
end