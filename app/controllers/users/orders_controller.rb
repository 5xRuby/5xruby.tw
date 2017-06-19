module Users
  class OrdersController < ApplicationController
    def create
      build_resource
      save_resource
    end

    private

    def save_resource
    end

    def build_resource
      @resource = current_activity.orders.new
    end

    def current_activity
      @activity ||= Activity.find(allowed_params[:purchasable_id])
    end

    def allowed_params
      params.require(:order).permit(:purchasable_id, :purchasable_type)
    end
  end
end
