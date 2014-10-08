class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.string :name
      t.text :description
      t.string :link
      t.string :image
      t.boolean :is_online, null: false, default: false
      t.integer :sort_id, null: false, default: 0

      t.timestamps
    end
  end
end
