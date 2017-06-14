class ChangeOrderPolymorphicColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :activitiable_type, :purchasable_type
    rename_column :orders, :activitiable_id, :purchasable_id
  end
end
