
class DurationValidator < ActiveModel::Validator

  LIMIT_DURATION = 30
  MULTIPLIER = 5

  def validate(record)

    duration = record.end_time - record.start_time

    if duration > (LIMIT_DURATION * 60)
      record.errors[:start_time] << "Duration should be less than #{LIMIT_DURATION} minutes"
    end

    if duration % (MULTIPLIER * 60) != 0
      record.errors[:start_time] << "Time should be divided by #{MULTIPLIER} minutes"
    end

    if duration <= 0
      record.errors[:start_time] << 'End time should be graiter than start time'
    end

  end
end