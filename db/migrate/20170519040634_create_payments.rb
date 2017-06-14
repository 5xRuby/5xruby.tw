class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.string :state
      t.string :type
      t.string :identifier, null: false, default: ''
      t.datetime :paid_at
      t.datetime :expiry_at

      t.timestamps
    end
  end
end
