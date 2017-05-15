class RemoveColumnsFromCampTemplates < ActiveRecord::Migration[5.0]
  def change
    remove_column :camp_templates, :lang, :string
    remove_column :camp_templates, :status, :string
  end
end
