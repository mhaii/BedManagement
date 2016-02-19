require 'json'
class AdmitsController < ApplicationController
  before_action :set_admit, only: [:show, :update, :destroy]
  before_action :get_admits, only: [:index]

  def queue
    @admits = Admit.where status: [0, 1]
    render 'detail'
  end

  def today
    @admits = Admit.where status: 1, admitted_date: Date.today.beginning_of_day..Date.today.end_of_day
    render 'detail'
  end

  def out_soon
    @admits = Admit.where status: [2, 3], edd: 1.month.ago..3.days.from_now
    render 'detail'
  end

  def create
    @admit = Admit.new(get_request_body)
    respond_to do |format|
      if @admit.save
        format.json { render :show, status: :created, location: @admit }
      else
        format.json { render json: @admit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_params = get_request_body
    if @admit.status != update_params.status
      if update_params.status == 3
        @admit.room.update status: :availableSoon
      elsif update_params.status == 4
        update_params.room_id = nil
      end
    end
    if update_params.room_id
      if @admit.room
        @admit.room.update status: :available
      end
      Room.find(update_params.room_id).update status: :occupied
    else
      @admit.room.update status: :available
    end
    respond_to do |format|
      if @admit.update(update_params)
        format.json { render :show, status: :ok, location: @admit }
      else
        format.json { render json: @admit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admit.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_admit
      @admit = Admit.find_by(id: params[:id])
      unless @admit
        render json: { error: 'not found' }
      end
    end

    def get_admits
      @admits = Admit.all
    end

    def get_request_body
      JSON.parse(request.body.string)
    end
end
