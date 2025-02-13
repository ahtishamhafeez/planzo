class AddDeletedAtToProjectUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :project_users, :deleted_at, :datetime
  end
end
