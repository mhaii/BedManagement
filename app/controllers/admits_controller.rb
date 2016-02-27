require 'json'
class AdmitsController < ApplicationController
  before_action { render text: 'Loading API in HTML is prohibited', status: 405 if params[:format].nil? }
  before_action :set_admit, only: [:show, :update, :destroy]
  before_action :get_admits, only: [:index]

  def in_icu
    @admits = query.where(status: -1)
    render :detail
  end

  def queue
    @admits = query.where(status: [0, 1]).order :admitted_date
    render :detail
  end

  def today
    @admits = query.where(status: 1, admitted_date: Date.today.beginning_of_day..Date.today.end_of_day).order :admitted_date
    render :detail
  end

  def out_soon
    @admits = query.where(status: [2, 3], edd: 1.month.ago..3.days.from_now).order :edd
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
      @admits = Admit
    end

    def query
      Admit.includes([:patient, room: :ward])
    end

    def get_request_body
      JSON.parse(request.body.string)
    end
end
