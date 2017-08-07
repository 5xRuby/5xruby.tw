class ChangeFormsToSurveys < ActiveRecord::Migration[5.0]
  def change
    rename_table :forms, :surveys
    rename_column :surveys, :fields, :questions
    rename_column :activities, :form_id, :survey_id
  end
end
