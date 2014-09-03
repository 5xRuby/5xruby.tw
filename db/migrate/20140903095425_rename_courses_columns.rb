class RenameCoursesColumns < ActiveRecord::Migration
  def change
    rename_column :courses, :total_attendees, :maximum_attendees
    rename_column :courses, :current_attendees, :total_attendees
  end
end
