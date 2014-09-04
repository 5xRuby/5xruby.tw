class AddHoursToStages < ActiveRecord::Migration
  def change
    add_column :stages, :hours, :float, null: false, default: 1
    Stage.find_each do |stage|
      stage.update_attribute :hours, (stage.end_at - stage.start_at) / 3600
    end
  end
end
