class AddRegisterIframeHtmlToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :iframe_html, :string
  end
end
