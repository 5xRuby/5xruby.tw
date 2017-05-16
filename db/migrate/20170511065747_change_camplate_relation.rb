class ChangeCamplateRelation < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :template, foreign_key: { to_table: :camp_templates }
  end
end
