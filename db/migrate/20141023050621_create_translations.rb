class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :translatable, polymorphic: true, index: true
      t.string :column
      t.string :locale
      t.text :text

      t.timestamps
    end
  end
end
