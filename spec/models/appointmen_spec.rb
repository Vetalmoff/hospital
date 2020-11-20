require 'rails_helper'
require_relative '../../app/models/doctor'
require_relative '../../app/models/user'

RSpec.describe Appointment, :type => :model do


  subject { described_class.new(start_time: Time.new(2020, 01, 01, 12, 0, 0),
                                end_time: Time.new(2020, 01, 01, 12, 10, 0))
  }


  describe 'validations of presence' do

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a start time" do
      subject.start_time = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a end time" do
      subject.end_time = nil
      expect(subject).to_not be_valid
    end
  end

  describe "appointment should belong to user and doctor" do
    it { should belong_to(:user) }
    it { should belong_to(:doctor) }
  end

end

