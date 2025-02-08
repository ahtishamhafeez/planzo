class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false, index: { unique: true }
      t.datetime :start_time, null: false
      t.jsonb :duration, null: false, index: true
      t.text :description
      t.timestamps
    end
  end
end
