class RemoveSortIdFromStages < ActiveRecord::Migration
  def change
    remove_column :stages, :sort_id, :integer
  end
end
