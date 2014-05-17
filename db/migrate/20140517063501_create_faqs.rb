class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :question, null: false
      t.text :answer, null: false
      t.boolean :is_online, null: false, default: false

      t.timestamps
    end
  end
end
