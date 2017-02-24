class Camp < Settingslogic
  source "#{Rails.root}/config/camp.yml"

  class << self
    def days_before_begining
      (begin_date_parsed - Date.today).to_i
    end

    def begun?
      @past ||= begin_date_parsed.past?
    end

    def begin_date_parsed
      @begin_date_parsed ||= Date.parse(begin_date)
    end

    def days_before_ending
      (end_date_parsed - Date.today).to_i
    end

    def ended?
      @ended ||= end_date_parsed.past?
    end

    def end_date_parsed
      @end_date_parsed ||= Date.parse(end_date)
    end

    def courses
      @courses ||= lessons.map do |lesson|
        raise "Course not found by permalink '#{lesson['course_permalink']}'" unless lesson['record'] = Course.find_by(permalink: lesson['course_permalink'])
        lesson
      end
    end
  end
end
