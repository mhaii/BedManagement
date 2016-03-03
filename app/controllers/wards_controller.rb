require 'json'
class WardsController < ApplicationController
  before_action :json_only
  before_action :set_ward, only: [:show, :update, :destroy, :ward_index]
  before_action :get_wards, only: [:index]

  def ward_index
    @ward = Ward.includes(rooms: [admit: :patient]).find_by(id: params[:id])
    error_not_found unless @ward
  end

  def wards_index
    @wards = Ward.includes(rooms: [admit: :patient])
  end

  def free
    @wards = Ward.joins(:rooms).where('rooms.status= 0').group(:ward_id).pluck :name, :remark, 'count(*)'
    render 'index'
  end

  def create
    @ward = Ward.new(get_request_body)

    respond_to do |format|
      if @ward.save
        format.json { render :show, status: :created, location: @ward }
      else
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ward.update(get_request_body)
        format.json { render :show, status: :ok, location: @ward }
      else
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ward.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_ward
      @ward = Ward.find_by(id: params[:id])
      error_not_found unless @ward
    end

    def get_wards
      @wards = Ward.all
    end

    def get_request_body
      JSON.parse(request.body.string)
    end
end
