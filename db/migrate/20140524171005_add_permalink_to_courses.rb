class AddPermalinkToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :permalink, :string, null: false, default: SecureRandom.hex(4)
    add_index :courses, :permalink, unique: true
  end
end
