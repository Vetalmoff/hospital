require 'rails_helper'

RSpec.describe User, :type => :model do

  subject { build(:user) }

  describe "validation of presence" do
    let(:rand_user) { build(:random_user) }

    it "is valid with valid attributes" do
      # p rand_user
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
    before(:example) do
      previous_user = create(:user)
    end

    it 'is invalid if the email is not unique' do
      # create(:user)
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
