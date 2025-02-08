class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, index: true
      t.datetime :start_time, index: true
      t.datetime :end_time, index: true
      t.jsonb :duration, null: false, index: true
      t.text :description
      t.references :project_user, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
