class AddApplyLinkToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :apply_link, :string
  end
end
