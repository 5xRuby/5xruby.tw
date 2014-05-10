class AddDurationToStages < ActiveRecord::Migration
  def change
    add_column :stages, :duration, :float, null: false, default: 0
  end
end
