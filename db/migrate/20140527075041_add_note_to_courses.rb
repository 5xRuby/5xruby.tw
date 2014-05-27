class AddNoteToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :note, :text
  end
end
