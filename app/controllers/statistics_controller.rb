class StatisticsController < ApplicationController
  before_action :json_and_xls

  def check_out # / arr.size
    @steps = CheckOutStep.joins(:admit).where('admits.status IN (3, 4) AND time_ended IS NOT NULL AND time_started IS NOT NULL').group(:step).select('AVG(UNIX_TIMESTAMP(time_ended)- UNIX_TIMESTAMP(time_started))/60 as "average_duration", check_out_steps.step').order(:step)
  end

  def in_out_rate
    #admit = Admit.where(status: [2, 3, 4])
    @stats = {startDischargeProcess:  [1, 1, 0, 0, 0, 0, 7, 31, 38, 31, 17, 9, 9, 4, 2, 7, 7, 4, 8, 14, 6, 5, 0, 1],
              endOfDischargedProcess: [0, 0, 0, 0, 0, 0, 0, 2, 10, 30, 42, 48, 25, 19, 5, 11, 2, 12, 0, 2, 1, 0, 0, 0],
              newPatientAdmitted:     [0, 0, 0, 0, 0, 0, 2, 9, 18, 23, 39, 18, 10, 11, 9, 4, 4, 4, 2, 0, 0, 1, 1, 0]}
  end
end
