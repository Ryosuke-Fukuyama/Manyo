class AddProgressToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :progress, :string, default: false, null: false
  end
end
