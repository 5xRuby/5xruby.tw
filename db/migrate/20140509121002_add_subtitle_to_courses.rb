class AddSubtitleToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :subtitle, :string
  end
end
