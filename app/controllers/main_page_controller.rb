class MainPageController < ApplicationController
  def index
    @doctors = Doctor.all.order(:name)
  end
end
