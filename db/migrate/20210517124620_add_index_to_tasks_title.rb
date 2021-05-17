class AddIndexToTasksTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :title, unique: true
  end
end
