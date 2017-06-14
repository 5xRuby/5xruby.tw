class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :title
      t.json :fields

      t.timestamps
    end

    add_reference :activities, :form, foreign_key: true
  end
end
