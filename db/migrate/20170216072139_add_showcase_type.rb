class AddShowcaseType < ActiveRecord::Migration[5.0]
  def change
    add_column :showcases, :category, :integer
  end
end
