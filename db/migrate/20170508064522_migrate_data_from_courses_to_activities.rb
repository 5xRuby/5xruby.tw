class MigrateDataFromCoursesToActivities < ActiveRecord::Migration[5.0]
  def change
    Activity::Talk.reset_column_information
    is_onlines = Course.all.map {|c| [c.talks.first.id, c.is_online]}
    is_onlines.each do |id, is_online|
      Activity::Talk.find(id).update_attributes(is_online: is_online)
    end
  end
end
