class CreateRelationships < ActiveRecord::Migration
  def change
    change_table :admits do |t|
      t.integer   :doctor_id, null: true
      t.integer   :patient_id
      t.integer   :room_id,   null: true
    end

    change_table :rooms do |t|
      t.integer   :ward_id
    end
  end
end
