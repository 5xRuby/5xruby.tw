namespace :data_migration do
  task :activities => :environment do |task, args|
    # migrate some values from courses to activities
    ActiveRecord::Base.transaction do
      Course.find_each do |course|
        if course.talks.find_by(permalink: course.permalink)
          # the talk and relation has established, do nothing
        elsif talk = Activity::Talk.find_by(permalink: course.permalink)
          # the talk has existed, but relation hasn't
          ActivityCourse.create(activity_id: talk.id, course_id: course.id)
        else
          # the talk and relation haven't existed, create the talk
          talk = course.talks.build(
            title: course.title,
            permalink: course.permalink,
            is_online: course.is_online ? true : false,
            note: I18n.t('note'),
            payment_note: I18n.t('payment_note')
          )
          talk.save!(validate: false)
          ActivityCourse.create!(activity_id: talk.id, course_id: course.id)
        end

        # why why why? why is this course having no stage? =.=
        if course.id == 5
          course.stages.create!(title: "Git", date: Date.new(2014, 9, 3), start_at: Time.new(2014, 9, 3, 19), end_at: Time.new(2014, 9, 3, 21), hours: 2, description: "It's Git!")
        end
      end

      # migrate some values from camp_templates to activities
      CampTemplate.find_each do |template|
        # check if template's camp exist
        unless Activity::Camp.find_by(template_id: template.id)
          camp = template.camps.build(
            title: template.payload["title"],
            permalink: "camp-2017-#{Activity::Camp.count + 1}",
            is_online: template.status == "active" ? true : false,
            note: I18n.t('note'),
            payment_note: I18n.t('payment_note')
          )
          camp.save!(validate: false)
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

        # update the courses
        courses.each do |course|
          course_in_template = template.payload['lessons'].select{|l| l['course_permalink'] == course.permalink}.first
          time_description = course_in_template['time_description'].map{|c| "<li>#{c}</li>"}.join("")
          course.update_attributes!(
            time_limit: course_in_template['time_limit'],
            time_description: "<ul>#{time_description}</ul>"
          )
        end

        # remove redundant things from the template
        loader_keys = CampTemplateLoader.new.to_h.keys
        template_keys = template.payload.to_h.keys
        redudant_keys = template_keys - loader_keys
        missing_keys = loader_keys - template_keys

        new_hash = template.payload.except *(redudant_keys)
        new_hash.merge! Hash[missing_keys.map { |k| [k, CampTemplateLoader.new.to_h[k]] }]

        template.update_attributes!(payload: new_hash)
      end

      puts "migration succeed!"
    end
  end
end
