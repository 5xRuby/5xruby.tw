module TapPayService
  class << self
    def build(card, user: , order:)
      hash = {
        prime: card.prime,
        amount: order.amount,
        details: "An activity",
        ptradeid: order.serial,
        cardholder: {
          name: user.name,
          email: user.email,
          phonenumber: user.phone || "+886223315247"
        }
      }
      req = TapPay::Request::PayByPrime.new(hash)
    end
  end
end
