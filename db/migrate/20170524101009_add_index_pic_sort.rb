class AddIndexPicSort < ActiveRecord::Migration[5.0]
  def change
    add_column :index_pictures, :ordering, :integer
  end
end
