class AddRulesToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :rules, :json, default: {}
  end
end
