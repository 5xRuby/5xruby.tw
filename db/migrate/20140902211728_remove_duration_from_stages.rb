class RemoveDurationFromStages < ActiveRecord::Migration
  def change
    remove_column :stages, :duration, :float
  end
end
