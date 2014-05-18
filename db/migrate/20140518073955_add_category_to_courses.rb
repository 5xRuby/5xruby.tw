class AddCategoryToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :category, index: true
  end
end
