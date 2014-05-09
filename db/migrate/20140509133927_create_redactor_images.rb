class CreateRedactorImages < ActiveRecord::Migration
  def change
    create_table :redactor_images do |t|
      t.string :image, null: false

      t.timestamps
    end
  end
end
