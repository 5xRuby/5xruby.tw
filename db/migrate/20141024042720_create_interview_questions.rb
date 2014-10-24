class CreateInterviewQuestions < ActiveRecord::Migration
  def change
    create_table :interview_questions do |t|
      t.text :question, null: false
      t.text :answer, null: false
      t.integer :sort_id, null: false, default: 0
      t.boolean :is_online, null: false, default: false

      t.timestamps
    end
  end
end
