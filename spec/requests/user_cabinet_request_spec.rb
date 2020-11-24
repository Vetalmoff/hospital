require 'rails_helper'

RSpec.describe "UserCabinets", type: :request do

  describe "GET /past_appointments" do
    it "returns http success" do
      get "/user_cabinet/past_appointments"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /future_appointments" do
    it "returns http success" do
      get "/user_cabinet/future_appointments"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /account" do
    it "returns http success" do
      get "/user_cabinet/account"
      expect(response).to have_http_status(:success)
    end
  end

end
