class AddCoursesCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :courses_count, :integer, null: false, default: 0
    Category.find_each{ |category| Category.reset_counters category.id, :courses }
  end

  def down
    remove_column :categories, :courses_count, :integer, null: false, default: 0
  end
end
