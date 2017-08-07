class ChangeOrderFieldsToAns < ActiveRecord::Migration[5.0]
  def up
    rename_column :orders, :fields, :ans
    change_column :orders, :ans, :jsonb
    change_column_default :orders, :ans, {}
    add_index :orders, :ans, using: :gin
  end

  def down
    remove_index :orders, :ans
    change_column_default :orders, :ans, nil
    change_column :orders, :ans, :json
    rename_column :orders, :ans, :fields
  end
end
