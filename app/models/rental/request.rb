module Rental
  class Request
    TAX_RATE = 0.05
    include ActiveModel::Model
    attr_accessor :days, :name, :email, :phone
    validates :name, :email, :phone, presence: true

    def price
      @price ||= days.sum(&:price).round
    end

    def tax
      @tax ||= (price * TAX_RATE).round
    end

    def total_price
      @total_price ||= price + tax
    end

    def initial_payment
      @initial_payment ||= (total_price * 0.3).round(-2)
    end

    def back_payment
      @back_payment ||= total_price - initial_payment
    end

    def flush_catch!
      @price = @tax = @total_price = nil
    end

    def days_attributes= attributes
      self.days = attributes.values.map{|attrs| Day.new attrs }
    end
  end
end