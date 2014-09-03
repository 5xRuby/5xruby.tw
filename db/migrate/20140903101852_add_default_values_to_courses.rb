class AddDefaultValuesToCourses < ActiveRecord::Migration
  def up
    change_column :courses, :maximum_attendees, :integer, null: false, default: 30
    change_column :courses, :total_attendees, :integer, null: false, default: 0
    change_column :courses, :minimum_attendees, :integer, null: false, default: 5
  end

  def down
    change_column :courses, :maximum_attendees, :integer, null: true, default: nil
    change_column :courses, :total_attendees, :integer, null: true, default: nil
    change_column :courses, :minimum_attendees, :integer, null: true, default: 5
  end
end
