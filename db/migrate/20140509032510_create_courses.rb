class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :image
      t.string :title, null: false, index: true
      t.string :summary
      t.text :description
      t.text :what_will_learn

      t.timestamps
    end
  end
end
