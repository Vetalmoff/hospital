require 'rails_helper'

RSpec.describe Appointment, :type => :model do

  duration = DurationValidator::LIMIT_DURATION
  multiplier = DurationValidator::MULTIPLIER
  begin_working_day = WorkingHoursValidator::START_TIME
  end_working_day = WorkingHoursValidator::END_TIME

  before(:all) do
    @doctor = Doctor.create(name: 'Anatolii',
                           position: 'therapist',
                           img: 'http://aaaaa.jpg')
    @user = User.create(name: 'Oleksandr',
                       email: 'oleksandr.@gmail.com',
                       password: '111111',
                       role: 'user')
    @admin = User.create(name: 'Bogdan',
                        email: 'bogdan.@gmail.com',
                        password: '111111',
                        role: 'admin')
    @appointment1 = Appointment.create!(start_time: Time.new(2021, 01, 01, 11, 10, 0),
                                       end_time: Time.new(2021, 01, 01, 11, 20, 0),
                                       doctor_id: @doctor.id,
                                       user_id: @user.id)
    @appointment2 = Appointment.create!(start_time: Time.new(2021, 01, 01, 12, 20, 0),
                                       end_time: Time.new(2021, 01, 01, 12, 25, 0),
                                       doctor_id: @doctor.id,
                                       user_id: @user.id)
    @appointment3 = Appointment.create!(start_time: Time.new(2021, 01, 01, 12, 40, 0),
                                       end_time: Time.new(2021, 01, 01, 12, 45, 0),
                                       doctor_id: @doctor.id,
                                       user_id: @user.id)
    @appointment4 = Appointment.create!(start_time: Time.new(2021, 01, 01, 14, 0, 0),
                                       end_time: Time.new(2021, 01, 01, 14, 20, 0),
                                       doctor_id: @doctor.id,
                                       user_id: @user.id)
    @appointment5 = Appointment.create!(start_time: Time.new(2021, 01, 01, 14, 20, 0),
                                       end_time: Time.new(2021, 01, 01, 14, 40, 0),
                                       doctor_id: @doctor.id,
                                       user_id: @user.id)

  end



  subject { described_class.new(start_time: Time.new(2021, 01, 01, 16, 0, 0),
                                end_time: Time.new(2021, 01, 01, 16, 10, 0),
                                doctor_id: @doctor.id,
                                user_id: @user.id)

  }



  describe 'validations of presence' do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    # it "is not valid without a start time" do
    #   subject.start_time = nil
    #   expect(subject).to_not be_valid
    # end

    # it "is not valid without a end time" do
    #   subject.end_time = nil
    #   expect(subject).to_not be_valid
    # end
  end

  describe 'duration validation' do
    it "should be less than #{duration}" do
        subject.end_time = Time.new(2021, 01, 01, 16, 40, 0)
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Duration should be less than #{duration} minutes")
    end

    it "should be divided by #{multiplier}" do
      subject.end_time = Time.new(2021, 01, 01, 16, 23, 0)
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Time should be divided by #{multiplier} minutes")
    end

    it "should be positive" do
      subject.end_time = Time.new(2021, 01, 01, 16, 0, 0)
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: End time should be later than start time")
    end
  end

  describe 'working hours validation' do
    it "should be later then #{begin_working_day} hours" do
      subject.start_time = Time.new(2021, 01, 02, 8, 00, 0)
      subject.end_time = Time.new(2021, 01, 02, 8, 10, 0)
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Start time Start time should be later than #{begin_working_day}-00")
    end

    it "should be earlier then #{end_working_day} hours" do
      subject.end_time = Time.new(2021, 01, 01, 20, 00, 0)
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Duration should be less than #{duration} minutes, End time Start time should be earlier than #{end_working_day}-00")
    end

    it "should be later then now" do
      subject.start_time = Time.new(2000, 01, 01, 12, 00, 0)
      subject.end_time = subject.start_time + 300
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Start time Start time should be later than current time")
    end
  end

  describe 'when appointment is  bad' do
    where( :start, :finish) do
      [
        [Time.new(2021, 01, 01, 10, 50, 0), Time.new(2021, 01, 01, 11, 15, 0)],
        [Time.new(2021, 01, 01, 12, 40, 0), Time.new(2021, 01, 01, 12, 50, 0)],
        [Time.new(2021, 01, 01, 14, 25, 0), Time.new(2021, 01, 01, 14, 30, 0)],
        [Time.new(2021, 01, 01, 12, 35, 0), Time.new(2021, 01, 01, 12, 50, 0)]
      ]
    end

    with_them do
      it "should raise an error" do
        obj = described_class.new(start_time: start,
                                  end_time: finish,
                                  doctor_id: @doctor.id,
                                  user_id: @user.id)
        expect(obj).to_not be_valid
      end
    end
  end

  describe 'when appointment is  good' do
    where( :start, :finish) do
      [
        [Time.new(2021, 01, 01, 12, 0, 0), Time.new(2021, 01, 01, 12, 10, 0)],
        [Time.new(2021, 01, 01, 14, 50, 0), Time.new(2021, 01, 01, 15, 0, 0)],
        [Time.new(2021, 01, 01, 12, 25, 0), Time.new(2021, 01, 01, 12, 40, 0)],
        [Time.new(2021, 01, 01, 16, 35, 0), Time.new(2021, 01, 01, 16, 50, 0)]
      ]
    end

    with_them do
      it "should pass validation" do
        obj = described_class.new(start_time: start,
                                  end_time: finish,
                                  doctor_id: @doctor.id,
                                  user_id: @user.id)
        expect(obj).to be_valid
      end
    end
  end

  it { should belong_to(:doctor) }
  it { should belong_to(:user) }
end


