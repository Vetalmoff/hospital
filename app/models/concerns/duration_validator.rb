
class DurationValidator < ActiveModel::Validator

  LIMIT_DURATION = 30
  MULTIPLIER = 5

  def validate(record)

    duration = record.end_time - record.start_time

    if duration > (LIMIT_DURATION * 60)
      record.errors[:base] << "Duration should be less than #{LIMIT_DURATION} minutes"
    end

    if duration % (MULTIPLIER * 60) != 0
      record.errors[:base] << "Time should be divided by #{MULTIPLIER} minutes"
    end

    if duration <= 0
      record.errors[:base] << 'End time should be later than start time'
    end

  end
end