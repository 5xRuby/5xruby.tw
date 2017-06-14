class ChangeColumnInActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :is_online, :boolean
    remove_column :activities, :status, :string
  end
end
