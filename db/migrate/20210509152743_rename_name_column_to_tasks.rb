class RenameNameColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :name, :title
  end
end
