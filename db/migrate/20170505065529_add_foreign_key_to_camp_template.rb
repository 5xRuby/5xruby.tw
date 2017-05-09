class AddForeignKeyToCampTemplate < ActiveRecord::Migration[5.0]
  def change
    add_reference :camp_templates, :activity, foreign_key: true
  end
end
