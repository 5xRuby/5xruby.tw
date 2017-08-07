module Permalinkable
  extend ActiveSupport::Concern

  module ClassMethods
    def permalinkable source_column = :name, target_column = :permalink
      validates target_column, presence: true, uniqueness: true
      before_validation :set_permalink, if: Proc.new { |record| record.send(target_column).blank? }
      define_method(:to_param){ permalink }
      define_method(:next_permalink){
        Permalinkable.next_permalink permalink
      }
      private define_method(:set_permalink){
        send("#{target_column}=", send(source_column)&.parameterize)
      }
    end
  end

  def self.next_permalink permalink
    if number = permalink[/(\d+)$/, 1]
      permalink.sub(/(\d+)$/, (number.to_i + 1).to_s)
    else
      permalink += '-1'
    end
  end
end