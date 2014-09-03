class AddDefaultValuesToStages < ActiveRecord::Migration
  def up
    change_column :stages, :date, :date, default: '2014-09-03', null: false
    change_column :stages, :start_at, :time, default: '00:00:00', null: false
    change_column :stages, :end_at, :time, default: '00:00:00', null: false
  end
end
