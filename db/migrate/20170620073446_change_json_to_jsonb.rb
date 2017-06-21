class ChangeJsonToJsonb < ActiveRecord::Migration[5.0]
  def change
    enable_extension "btree_gin"

    remove_column :surveys, :questions, :json
    add_column :surveys, :questions, :jsonb, default: {}, null: false
    add_index :surveys, :questions, using: :gin
  end
end
