require 'json'
class RoomsController < ApplicationController
  before_action :json_only
  before_action :set_room, only: [:show, :update, :destroy]
  before_action :get_rooms, only: [:index]

  def create
    @room = Room.new(get_request_body)

    respond_to do |format|
      if @room.save
        format.json { render :show, status: :created, location: @room }
      else
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(get_request_body)
        format.json { render :show, status: :ok, location: @room }
      else
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_room
      @room = Room.find_by_id(params[:id])
      unless @room
        render json: { error: params[:id] }
      end
    end

    def get_rooms
      @rooms = Room.all
    end

    def get_request_body
      JSON.parse(request.body.string)
    end
end
