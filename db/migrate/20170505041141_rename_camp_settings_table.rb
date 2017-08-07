class RenameCampSettingsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :camp_settings, :camp_templates
  end
end
