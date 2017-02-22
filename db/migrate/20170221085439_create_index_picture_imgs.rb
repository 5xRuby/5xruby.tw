class CreateIndexPictureImgs < ActiveRecord::Migration[5.0]
  def change
    create_table :index_picture_imgs do |t|
      t.string :src
      t.string :lang
      t.string :size
      t.integer :index_picture_id
    end
  end
end
