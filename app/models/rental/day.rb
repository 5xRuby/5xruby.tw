require 'time'

module Rental
  class Day
    include ActiveModel::Model
    WEEKEND_PRICE, WEEKDAY_PRICE = 1800.0, 1500.0
    WEEKEND_RANGE = [['8:00', '12:00'], ['13:00', '17:00'], ['18:00', '22:00']]
    WEEKDAY_RANGE = [['19:00', '22:00']]

    attr_accessor :date, :start_at, :end_at
    validate :must_be_available, :must_be_in_range

    # ex. Day.new('2014-11-23', '08:00', '12:00')
    def initialize(date, start_at, end_at)
      @date     = Date.parse(date)
      @start_at = Time.parse(start_at)
      @end_at   = Time.parse(end_at)
    end

    def hours
     (end_at - start_at) / 3600
    end

    def price_per_hour
      (date.sunday? || date.saturday?) ? WEEKEND_PRICE : WEEKDAY_PRICE
    end

    def price
      price_per_hour * hours
    end

    private

    def must_be_available
      errors.add(:end_at, :must_be_greater_than_start_at) if start_at >= end_at
    end

    def must_be_in_range
      if date.sunday? || date.saturday?
        check_range weekend_ranges
      else
        check_range weekday_ranges
      end
    end

    def check_range ranges
      ranges.each do |range|
        if range.include?(start_at.seconds_since_midnight) &&
           range.include?(end_at.seconds_since_midnight)
           return
        end
      end
      errors.add(:base, :time_must_be_in_available_range)
    end

    # Range of seconds since midnight
    # ex. to_time_range [['8:00', '12:00'], ['13:00', '17:00']]
    def to_time_range! ary_ary
      ary_ary.map! do |str_ary|
        str_ary.map!{|str| Time.parse(str).seconds_since_midnight }
        str_ary.first..str_ary.last
      end
    end

    def weekend_ranges
      to_time_range! WEEKEND_RANGE
    end

    def weekday_ranges
      to_time_range! WEEKDAY_RANGE
    end
  end
end