class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :stage, index: true, null: false
      t.date :date, index: true, null: false
      t.text :description

      t.timestamps
    end
  end
end
