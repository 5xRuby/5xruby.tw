class AddMoreDescToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :more_desc, :text
  end
end
