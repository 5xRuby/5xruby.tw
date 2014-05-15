class AddSortIdToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :sort_id, :integer, null: false, default: 0
  end
end
