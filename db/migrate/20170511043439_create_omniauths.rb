class CreateOmniauths < ActiveRecord::Migration[5.0]
  def change
    create_table :omniauths do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.json :payload

      t.timestamps
    end
  end
end
