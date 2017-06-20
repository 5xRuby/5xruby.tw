module OrderService
  class << self
    def build(order, user_id:, activity_id:, course_enrollments:, rule_id:)
      @order = order
      @order.user_id = user_id
      @order.activity_id = activity_id
      assign_course_enrollments(course_enrollments)
      assign_amount(rule_id)

      @order
    end

    private

    def assign_course_enrollments(course_enrollments)
      @selected_activity_courses = ActivityCourse.where(id: course_enrollments)

      @selected_activity_courses.each do |activity_course|
        @order.course_enrollments << Order::CourseEnrollment.new(activity_course: activity_course)
      end
    end

    def assign_amount(rule_id)
      rule = JSON.parse(@order.activity.rules)[rule_id].symbolize_keys
      @order.amount = rule.present? ? rule[:price] : @selected_activity_courses.map(&:price).sum
    end
  end
end
