class AddIsPublishedStateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_online, :boolean, null: false, default: false
  end
end
