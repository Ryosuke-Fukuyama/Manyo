class AddLimitToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :limit, :date, default: -> { 'NOW()' }, null: false
  end
  def down
    add_column :tasks, :limit, :date
  end
end
