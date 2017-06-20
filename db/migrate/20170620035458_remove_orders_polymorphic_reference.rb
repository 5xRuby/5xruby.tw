class RemoveOrdersPolymorphicReference < ActiveRecord::Migration[5.0]
  def change
    remove_reference :orders, :purchasable, polymorphic: true
    add_reference :orders, :activity
  end
end
