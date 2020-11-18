require 'rails_helper'

RSpec.describe User, :type => :model do

  subject { described_class.new(name: "Anything",
                                email: "Anything@gmail.com",
                                password: "somepassword"
                                )
  }

  describe "validation of presence" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'uniques' do
    before { described_class.create!(name: "Anything",
                                     email: "Anything@gmail.com",
                                     password: "somepassword") }
    it 'is invalid if the email is not unique' do
      expect(subject).to be_invalid
    end
  end

  describe 'password length' do
    it 'should be greater than 5 symbols' do
      subject.password = '111'
      expect(subject).to_not be_valid
    end
  end

  describe 'user' do
    it { should have_many(:appointments) }
    it { should have_secure_password }
  end

end
