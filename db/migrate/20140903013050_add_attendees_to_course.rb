class AddAttendeesToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :total_attendees, :integer
    add_column :courses, :current_attendees, :integer
    add_column :courses, :minimum_attendees, :integer, default: 5
  end
end
