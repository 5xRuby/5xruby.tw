class CreateIndexPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :index_pictures do |t|
      t.string :alt
      t.string :href
    end
  end
end
