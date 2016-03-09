namespace :scheduled_tasks do
  task clear_predischarge: :environment do
    Admit.joins(:room).where(status: 3).update_all('admits.status= 4, room_id= null, rooms.status= 0')
  end
end
