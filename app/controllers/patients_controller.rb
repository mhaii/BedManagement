class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :destroy]
  before_action :get_patients, only: [:index]

  def create
    @patient = Patient.new(patient_params)

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
      if @patient.update(patient_params)
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
      if Patient.exists?(params[:id])
        @patient = Patient.find(params[:id])
      else
        render json: { error: 'not found' }
      end
    end

    def get_patients
      @patients = Patient.all
    end

    def patient_params
      params.fetch(:patient, {})
    end
end

