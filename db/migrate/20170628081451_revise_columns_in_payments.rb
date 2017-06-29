class ReviseColumnsInPayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :state, :string
    remove_column :payments, :expiry_at, :datetime
    add_column :orders, :expiry_at, :datetime
    add_column :payments, :rectradeid, :string
  end
end
