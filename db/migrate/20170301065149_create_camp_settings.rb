class CreateCampSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :camp_settings do |t|
      t.json :payload
      t.string :status
      t.string :lang

      t.timestamps
    end
  end
end
