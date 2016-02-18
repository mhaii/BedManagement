class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]
  before_action :get_rooms, only: [:index]

  def create
    @room = Room.new(room_params)

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
      if @room.update(room_params)
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
      if Room.exists?(params[:id])
        @room = Room.find(params[:id])
      else
        render json: { error: 'not found' }
      end
    end

    def get_rooms
      @rooms = Room.all
    end

    def room_params
      params.fetch(:room, {})
    end
end
