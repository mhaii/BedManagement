class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.integer   :role
      t.string    :password_digest
      t.string    :remember_digest
    end
  end
end
