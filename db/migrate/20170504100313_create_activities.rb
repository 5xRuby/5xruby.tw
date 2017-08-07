class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :type
      t.string :title
      t.string :permalink
      t.string :status
      t.text :note
      t.text :payment_note

      t.timestamps
    end
  end
end
