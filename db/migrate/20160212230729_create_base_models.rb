class CreateBaseModels < ActiveRecord::Migration
  def change
    create_table :admits do |t|
      t.integer   :status, default: 0
      t.datetime  :admitted_date
      t.string    :diagnosis
      t.date      :edd, null: true
    end

    create_table :departments do |t|
      t.string    :name
      t.string    :abbreviation
    end

    create_table :doctors do |t|
      t.string    :name
    end

    create_table :patients, id: false, primary_key: :hn do |t|
      t.integer   :hn
      t.string    :first_name
      t.string    :last_name
      t.string    :phone,   null: true
      t.integer   :sex
      t.integer   :age,     null: true
    end

    create_table :rooms do |t|
      t.string    :number
      t.integer   :status, default: 0
      t.integer   :price
    end

    create_table :wards do |t|
      t.string    :name
      t.string    :remark,  null: true
      t.integer   :phone
    end
  end
end
