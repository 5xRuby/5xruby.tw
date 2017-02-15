class AddCoursePaymentNote < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :payment_note, :text
  end
end
