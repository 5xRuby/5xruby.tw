module OrderService
  class << self
    def build(order, user_id:, activity_id:, course_enrollments:, rule_id:)
      @order = order
      @order.user_id = user_id
      @order.activity_id = activity_id

      assign_serial
      assign_course_enrollments(course_enrollments)
      assign_amount(rule_id, course_enrollments)

      @order
    end

    private

    def assign_serial
      head = "RU"
      time = Time.zone.now.strftime("%Y%m%d")
      tail = ((Order.last&.id || 0) + 1).to_s.rjust(4, "0")
      check_number = ((time+tail).to_i % 10).to_s

      @order.serial = head + time + tail + check_number
    end

    def assign_course_enrollments(course_enrollments)
      @selected_activity_courses = ActivityCourse.where(id: course_enrollments)

      @selected_activity_courses.each do |activity_course|
        @order.course_enrollments << Order::CourseEnrollment.new(activity_course: activity_course)
      end
    end

    def assign_amount(rule_id, course_enrollments)
      rule = @order.activity.rules[rule_id]
      rule_courses = rule.present? ? rule[:selectedActivityCourseIDs] : []
      free_courses = rule.present? ? rule[:freeActivityCourseIDs] : []
      extra_courses = course_enrollments - rule_courses - free_courses

      extra_price = @selected_activity_courses.where(id: extra_courses).sum(&:price)
      @order.amount = if rule
                        rule[:price] + extra_price
                      else
                        extra_price
                      end
    end
  end
end
