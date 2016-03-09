class AdmitsController < ApplicationController
  before_action :json_only, except: [:check_out]
  before_action :json_and_xls,  only: [:check_out]
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
    @admits = query.where(status: 2, admitted_date: Date.today.beginning_of_day..Date.today.end_of_day).order :admitted_date
    render :detail
  end

  def out_soon
    @admits = query.where(status: [2, 3], edd: 1.month.ago..3.days.from_now).order :edd
    render :detail
  end

  def check_out
    query = Admit.includes([:patient, :doctor, :check_out_steps, room: :ward])
    if @current_user.ward_id
      @admits = query.joins(:room).where "admits.status = 3 AND rooms.ward_id = #{@current_user.ward_id}"
    else
      respond_to do |format|
        format.xls { @admits = query.where status: [3, 4] }
        format.json do
          @admits = query.where status: 3
          render :detail
        end
      end
    end
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
      error_not_found unless @admit
    end

    def get_admits
      @admits = Admit.all
    end

    def query
      Admit.includes([:patient, :doctor, room: :ward])
    end

    def get_request_body
      JSON.parse(request.body.string).except('doctor', 'patient', 'room')
    end
end
