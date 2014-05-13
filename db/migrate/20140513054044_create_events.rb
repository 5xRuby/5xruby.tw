class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :schedule, index: true, null: false
      t.references :speaker, index: true
      t.time :start_at, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
