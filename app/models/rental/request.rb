module Rental
  class Request
    TAX_RATE = 0.05
    include ActiveModel::Model
    attr_accessor :days, :name, :email, :phone
    validates :name, :email, :phone, presence: true

    def price
      @price ||= days.sum &:price
    end

    def tax
      @tax ||= price * TAX_RATE
    end

    def total_price
      @total_price ||= price + tax
    end

    def flush_catch!
      @price = @tax = @total_price = nil
    end
  end
end