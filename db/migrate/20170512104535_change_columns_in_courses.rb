class ChangeColumnsInCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :time_description, :text
    add_column :courses, :time_limit, :datetime
    remove_column :courses, :is_online, :boolean
    remove_column :courses, :payment_note, :text
    remove_column :courses, :note, :text
  end
end
