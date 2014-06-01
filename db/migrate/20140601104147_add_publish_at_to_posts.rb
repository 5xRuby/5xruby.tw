class AddPublishAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publish_at, :datetime
  end
end
