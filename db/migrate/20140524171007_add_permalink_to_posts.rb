class AddPermalinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :permalink, :string, null: false
    add_index :posts, :permalink, unique: true
  end
end
