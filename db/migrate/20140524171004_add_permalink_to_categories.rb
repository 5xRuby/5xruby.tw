class AddPermalinkToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :permalink, :string, null: false, default: SecureRandom.hex(4)
    add_index :categories, :permalink, unique: true
  end
end
