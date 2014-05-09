class ChangeSummaryTypeToCourses < ActiveRecord::Migration
  def up
    change_column :courses, :summary, :text
  end

  def down
    change_column :courses, :summary, :string
  end
end
