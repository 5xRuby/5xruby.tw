class AddPublishAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :publish_at, :datetime
    Post.find_each{ |post| post.update publish_at: post.created_at }
  end
end
