class CreateCheckOutSteps < ActiveRecord::Migration
  def change
    create_table :check_out_steps do |t|
      t.integer   :admit_id
      t.integer   :step
      t.datetime  :time_started
      t.datetime  :time_ended
    end
  end
end
