class MigrateDataBetweenTables < ActiveRecord::Migration[5.0]
  def change
    # migrate some values from courses to activities
    Course.all.each do |course|
      if course.talks.find_by(permalink: course.permalink)
        # the talk and relation has established, do nothing
      elsif talk = Activity::Talk.find_by(permalink: course.permalink)
        # the talk has existed, but relation hasn't
        ActivityCourse.create(activity_id: talk.id, course_id: course.id)
      else
        # the talk and relation haven't existed, create the talk
        course.talks.create(
          title: course.title,
          permalink: course.permalink,
          status: course.is_online ? :active : :inactive,
          note: course.note,
          payment_note: course.payment_note)
      end
    end

    # migrate some values from camp_templates to activities
    CampTemplate.all.each do |template|
      # check if template's camp exist
      unless template.camp
        camp = template.create_camp(
          title: template.payload["title"],
          permalink: "camp-2017-#{Activity::Camp.count + 1}",
          status: template.status,
          note: template.payload["note"],
          payment_note: template.payload["payment_note"]
        )
      end

      # find lessons contained in the template
      courses = template.
        payload["lessons"].
        map { |lesson| Course.find_by(permalink: lesson["course_permalink"]) }
      # check if the relation between camp and courses exist?
      courses.each do |course|
        unless camp.courses.find_by(permalink: course.permalink)
          # the relation doesn't exist, establish the relation
          ActivityCourse.create(activity_id: camp.id, course_id: course.id)
        end
      end
    end
  end
end
