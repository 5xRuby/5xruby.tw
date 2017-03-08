class AddPostImgColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :image_width, :integer
    add_column :posts, :image_height, :integer
  end
end
