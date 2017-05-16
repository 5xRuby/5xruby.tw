class ChangeColumnsInCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :time_description, :text
    add_column :courses, :time_limit, :datetime
  end
end
