require 'json'
class PatientsController < ApplicationController
  before_action { render text: 'Loading API in HTML is prohibited', status: 405 if params[:format].nil? }
  before_action :set_patient, only: [:show, :update, :destroy]
  before_action :get_patients, only: [:index]

  def create
    @patient = Patient.new(get_request_body)

    respond_to do |format|
      if @patient.save
        format.json { render :show, status: :created, location: @patient }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @patient.update(get_request_body)
        format.json { render :show, status: :ok, location: @patient }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @patient.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_patient
      @patient = Patient.find_by(hn: params[:id])
      unless @patient
        render json: { error: 'not found' }
      end
    end

    def get_patients
      @patients = Patient.all
    end

    def get_request_body
      JSON.parse(request.body.string)
    end
end

