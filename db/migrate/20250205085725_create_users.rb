class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name, index: true
      t.string :last_name
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest
      t.integer :role, default: 0, index: true
      t.timestamps
    end
    add_index :users, %i[email role], unique: true
  end
end
