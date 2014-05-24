class AddPermalinkToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :permalink, :string, null: false
    add_index :courses, :permalink, unique: true
  end
end
