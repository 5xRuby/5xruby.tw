class AddSortIdToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :sort_id, :integer, null: false, default: 0
  end
end
