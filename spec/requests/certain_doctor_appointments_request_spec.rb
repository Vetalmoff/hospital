require 'rails_helper'

RSpec.describe "CertainDoctorAppointments", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/certain_doctor_appointments/index"
      expect(response).to have_http_status(:success)
    end
  end

end
