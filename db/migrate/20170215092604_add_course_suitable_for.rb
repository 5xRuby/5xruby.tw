class AddCourseSuitableFor < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :suitable_for, :text
  end
end
