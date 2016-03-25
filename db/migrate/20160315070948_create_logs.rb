class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer   :user_id
      t.string    :model
      t.string    :attr
      t.string    :change
      t.string    :target_id
      t.datetime  :logged_at
    end
  end
end
