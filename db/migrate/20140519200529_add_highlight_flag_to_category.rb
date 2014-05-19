class AddHighlightFlagToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :is_highlighted, :boolean, null: false, default: false
  end
end
