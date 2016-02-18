class AdmitsController < ApplicationController
  before_action :set_admit, only: [:show, :edit, :update, :destroy]
  before_action :get_wards, only: [:index]

  def queue
    @admits = Admit.where status: %w(pending, confirmed)
    render 'admits/all'
  end

  def today
    @admits = Admit.where status: 'currentlyAdmit', admitted_date: Date.today
    render 'admits/all'
  end

  def new
    @admit = Admit.new
  end

  def create
    @admit = Admit.new(admit_params)

    respond_to do |format|
      if @admit.save
        format.html { redirect_to @admit, notice: 'Admit was successfully created.' }
        format.json { render :show, status: :created, location: @admit }
      else
        format.html { render :new }
        format.json { render json: @admit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admit.update(admit_params)
        format.html { redirect_to @admit, notice: 'Admit was successfully updated.' }
        format.json { render :show, status: :ok, location: @admit }
      else
        format.html { render :edit }
        format.json { render json: @admit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admit.destroy
    respond_to do |format|
      format.html { redirect_to admits_url, notice: 'Admit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_admit
      @admit = Admit.find(params[:id])
    end

    def get_wards
      @wards = Ward.all
    end

    def admit_params
      params.fetch(:admit, {})
    end
end
