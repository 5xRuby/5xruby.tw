class AddSerialToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :serial, :string, default: ''
  end
end
