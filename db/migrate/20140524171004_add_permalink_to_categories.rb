class AddPermalinkToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :permalink, :string, null: false
    add_index :categories, :permalink, unique: true
  end
end
