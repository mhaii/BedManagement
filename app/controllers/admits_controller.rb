class AdmitsController < ApplicationController
  before_action :set_admit, only: [:show, :update, :destroy]
  before_action :get_admits, only: [:index]

  def queue
    @admits = Admit.where status: %w(pending, confirmed)
    render 'detail'
  end

  def today
    @admits = Admit.where status: 'currentlyAdmit', admitted_date: Date.today
    render 'detail'
  end

  def out_soon
    @admits = Admit.where status: 'preDischarged'
    render 'detail'
  end

  def create
    @admit = Admit.new(admit_params)

    respond_to do |format|
      if @admit.save
        format.json { render :show, status: :created, location: @admit }
      else
        format.json { render json: @admit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admit.update(admit_params)
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

    def admit_params
      params.fetch(:admit, {})
    end
end
