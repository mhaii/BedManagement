require 'json'
class AdmitsController < ApplicationController
  before_action :set_admit, only: [:show, :update, :destroy]
  before_action :get_admits, only: [:index]

  def queue
    @admits = Admit.where(status: [0, 1]).order :admitted_date
    render :detail
  end

  def today
    @admits = Admit.where(status: 1, admitted_date: Date.today.beginning_of_day..Date.today.end_of_day).order :admitted_date
    render :detail
  end

  def out_soon
    @admits = Admit.where(status: [2, 3], edd: 1.month.ago..3.days.from_now).order :edd
    render :detail
  end

  def create
    @admit = Admit.new(get_request_body)
    if @admit.save
      render :show, status: :created, location: @admit
    else
      render json: @admit.errors, status: :unprocessable_entity
    end
  end

  def update
    if @admit.update(get_request_body)
      render :show, status: :ok, location: @admit
    else
      render json: @admit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @admit.destroy
    head :no_content
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
