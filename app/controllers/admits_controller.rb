class AdmitsController < ApplicationController
  before_action :set_admit, only: [:show, :edit, :update, :destroy]

  # GET /admits
  # GET /admits.json
  def index
    @admits = Admit.all
  end

  # GET /admits/1
  # GET /admits/1.json
  def show
  end

  # GET /admits/new
  def new
    @admit = Admit.new
  end

  # GET /admits/1/edit
  def edit
  end

  # POST /admits
  # POST /admits.json
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

  # PATCH/PUT /admits/1
  # PATCH/PUT /admits/1.json
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

  # DELETE /admits/1
  # DELETE /admits/1.json
  def destroy
    @admit.destroy
    respond_to do |format|
      format.html { redirect_to admits_url, notice: 'Admit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admit
      @admit = Admit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admit_params
      params.fetch(:admit, {})
    end
end
