class AddTimeToStages < ActiveRecord::Migration
  def change
    now = Time.now
    add_column :stages, :date, :date, null: false, default: now
    add_column :stages, :start_at, :time, null: false, default: now
    add_column :stages, :end_at, :time, null: false, default: now + 1.hour
  end
end
