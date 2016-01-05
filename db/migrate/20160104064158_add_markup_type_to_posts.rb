class AddMarkupTypeToPosts < ActiveRecord::Migration
  def up
    execute <<-SQL_END
      CREATE TYPE markup_type AS ENUM ('html', 'markdown');
    SQL_END
    add_column :posts, :markup_type, :markup_type, default: 'html'
  end

  def down
    change_table :posts do |t|
      t.remove :markup_type
    end
    execute "DROP TYPE markup_type;"
  end
end
