require 'rails_helper'

RSpec.describe Doctor, :type => :model do

  subject(:doctor) { build(:doctor) }

  describe 'validations of presence' do
    it "is valid with valid attributes" do
      expect(doctor).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(doctor).to_not be_valid
    end

    it "is not valid without a email" do
      subject.position = nil
      expect(doctor).to_not be_valid
    end

    it "is not valid without a password" do
      subject.img = nil
      expect(doctor).to_not be_valid
    end
  end

  describe 'uniques' do
    let(:previous_doctor) { create(:user) }

    it 'is invalid if the email is not unique' do
      expect(previous_doctor).to be_valid
      expect(doctor).to be_invalid
    end
  end

  describe 'name length' do
    it 'should be greater than 2 symbols' do
      subject.name = 'iv'
      expect(doctor).to_not be_valid
    end
  end

  describe "doctor" do
    it { should have_many(:appointments) }
  end

  describe 'img should be url link' do
    it 'should match the regex http://sometext.jpg' do
      expect(doctor.img).to match(/\A(http)?s?:?(\/\/[^"']*\.(?:png|jpg|jpeg|gif|png|svg))\z/)
    end
  end

end

