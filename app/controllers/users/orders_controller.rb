module Users
  class OrdersController < ApplicationController
    def create
      @order = Order.new
      @order = OrderService.build(
        @order,
        user_id: current_user.id,
        activity_id: allowed_params[:activity_id],
        course_enrollments: allowed_params[:course_enrollments],
        rule_id: allowed_params[:rule_id]
      )
      if @order.save
        redirect_to new_attendance_path(serial: @order.serial)
      else
        redirect_to camp_path, flash: { alert: @order.errors.full_messages }
      end
    end

    private

    def allowed_params
      params.require(:order).permit(:activity_id, :rule_id).tap do |whitelist|
        whitelist[:course_enrollments] = JSON.parse(params[:order][:course_enrollments])
      end
    end
  end
end
