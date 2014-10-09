class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :link
      t.string :summary
      t.text :description
      t.boolean :is_online

      t.timestamps
    end
  end
end
