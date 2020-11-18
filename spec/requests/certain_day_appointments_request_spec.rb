require 'rails_helper'

RSpec.describe "CertainDayAppointments", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/certain_day_appointments/index"
      expect(response).to have_http_status(:success)
    end
  end

end
