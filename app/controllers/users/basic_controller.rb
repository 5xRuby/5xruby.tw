module Users
  class BasicController < ApplicationController
    private

    def load_order
      @order ||= current_user.orders.find_by(serial: params[:serial]) || current_user.orders.pending.last
    end
  end
end
