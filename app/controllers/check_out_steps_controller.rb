class CheckOutStepsController < ApplicationController
  before_action :get_steps, only: [:start, :stop, :reset]
  before_action :set_steps, only: [:show]

  def start
    update time_started: DateTime.now
  end

  def stop
    update time_ended:   DateTime.now
  end

  def reset
    update time_ended: nil
  end

  def update(params)
    respond_to do |format|
      if @step.update(params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_step
      @step = CheckOutStep.find_by(id: params[:id])
      error_not_found unless @step
    end

    def get_steps
      @step = CheckOutStep.find_by(id: params[:id])
      error_not_found unless @step
    end

    def get_request_body
      JSON.parse(request.body.string)
    end
end