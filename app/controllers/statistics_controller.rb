class StatisticsController < ApplicationController
  before_action :json_and_xls

  def check_out
    @admits = Admit.includes([:patient, :doctor, :check_out_steps, room: :ward]).where status: [3, 4]
    respond_to do |format|
      format.xls
      format.json { render :detail }
    end
  end

  def in_out_rate
    #admit = Admit.where(status: [2, 3, 4])
    @stats = {startDischargeProcess:  [1, 1, 0, 0, 0, 0, 7, 31, 38, 31, 17, 9, 9, 4, 2, 7, 7, 4, 8, 14, 6, 5, 0, 1],
              endOfDischargedProcess: [0, 0, 0, 0, 0, 0, 0, 2, 10, 30, 42, 48, 25, 19, 5, 11, 2, 12, 0, 2, 1, 0, 0, 0],
              newPatientAdmitted:     [0, 0, 0, 0, 0, 0, 2, 9, 18, 23, 39, 18, 10, 11, 9, 4, 4, 4, 2, 0, 0, 1, 1, 0]}
  end
end
