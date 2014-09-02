class AddTimeToStages < ActiveRecord::Migration
  def change
    add_column :stages, :date, :date
    add_column :stages, :start_at, :time
    add_column :stages, :end_at, :time
  end
end
