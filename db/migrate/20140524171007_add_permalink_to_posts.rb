class AddPermalinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :permalink, :string, null: false, default: SecureRandom.hex(4)
    add_index :posts, :permalink, unique: true
  end
end
