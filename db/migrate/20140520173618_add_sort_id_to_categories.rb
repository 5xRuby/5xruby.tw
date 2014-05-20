class AddSortIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sort_id, :integer, null: false, default: 0
  end
end
