class AddIsOnlineToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :is_online, :boolean, null: false, default: false
  end
end
