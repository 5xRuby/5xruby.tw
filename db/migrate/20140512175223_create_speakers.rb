class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :avatar
      t.string :name, null: false, index: true
      t.text :summary
      t.boolean :is_online, null: false, default: false

      t.timestamps
    end
  end
end
