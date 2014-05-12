class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.references :course, index: true
      t.references :stage, index: true
      t.references :schedule, index: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone
      t.string :email, null: false, index: true
      t.integer :age
      t.string :gender
      t.text :message

      t.timestamps
    end
  end
end
