class ChangeCamplateRelation < ActiveRecord::Migration[5.0]
  def change
    remove_belongs_to :camp_templates, :activity, index: true
    add_reference :activities, :template, foreign_key: { to_table: :camp_templates }
  end
end
