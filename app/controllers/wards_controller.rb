class WardsController < ApplicationController
  before_action :set_ward, only: [:show, :edit, :update, :destroy, :rooms]
  before_action :get_wards, only: [:index, :rooms_all]

  def free_counts
    @wards = Ward.select(:id, :name, :remark)
  end

  def new
    @wards = Ward.new
  end

  def create
    @ward = Ward.new(ward_params)

    respond_to do |format|
      if @ward.save
        format.html { redirect_to @ward, notice: 'Ward was successfully created.' }
        format.json { render :show, status: :created, location: @ward }
      else
        format.html { render :new }
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ward.update(ward_params)
        format.html { redirect_to @ward, notice: 'ward was successfully updated.' }
        format.json { render :show, status: :ok, location: @ward }
      else
        format.html { render :edit }
        format.json { render json: @ward.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ward.destroy
    respond_to do |format|
      format.html { redirect_to wards_url, notice: 'ward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ward
      @ward = Ward.find(params[:id])
    end

    def get_wards
      @wards = Ward.all
    end

    def ward_params
      params.fetch(:ward, {})
    end
end
