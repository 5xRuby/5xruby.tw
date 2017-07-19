class AddSubtitleToActivitiesCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :activities_courses, :subtitle, :string
  end
end
