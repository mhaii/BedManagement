class DoctorsController < ApplicationController
  before_action :json_only
  before_action :get_rooms, only: [:index]

  def index
  end

  private
  def get_rooms
    @doctors = Doctor.all
  end
end
