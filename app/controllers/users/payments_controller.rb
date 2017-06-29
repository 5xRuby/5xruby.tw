module Users
  class PaymentsController < BasicController
    def new
      load_order
    end
  end
end
