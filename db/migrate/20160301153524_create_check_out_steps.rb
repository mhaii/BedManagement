class CreateCheckOutSteps < ActiveRecord::Migration
  def change
    create_table :check_out_steps do |t|
      t.integer   :admit_id,  null: false
      t.integer   :step,      null: false
      t.datetime  :time_started
      t.datetime  :time_ended
    end
  end
end
