namespace :scheduled_tasks do
  @dischargedCondition = 'admits.status= 4, room_id= null, rooms.status= 0'
  task clear_predischarge_daily: :environment do
    Admit.joins(:room).where(status: 3).update_all(@dischargedCondition)
  end

  task clear_predischarged_4hr: :environment do
    Admit.joins(:room, :check_out_steps).where(status: 3).where('step= 0 AND time_started < ?', 4.hour.ago).update_all(@dischargedCondition)
  end
end