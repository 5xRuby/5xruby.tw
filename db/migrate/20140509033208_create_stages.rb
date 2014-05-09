class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.references :course, null: false, index: true
      t.string :title, null: false
      t.text :description
      t.integer :sort_id, null: false, default: 0

      t.timestamps
    end
  end
end
