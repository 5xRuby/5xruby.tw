module Users
  class TappaysController < BasicController
    def new
      load_order
    end

    def create
      load_order
      card = TapPay::Response::CardInfo.new(allowed_params)
      req = TapPayService.build(card, user: current_user, order: @order)

      if (res = req.request) && res.success?
        OrderService.update!(@order, res: res)
        redirect_to root_path, flash: {
          notice: t("crud.created_successfully!", name: t("activerecord.models.order"))
        }
      else
        redirect_to new_payment_path, flash: { alert: t("errors.messages.order_unpaid") }
      end
    end

    private

    def allowed_params
      params.require(:credit_card).require(:data).permit(:prime, :bincode, :lastfour, :issuer, :funding, :type)
    end
  end
end
