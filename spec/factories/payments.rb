# frozen_string_literal: true

FactoryGirl.define do
  factory :payment do
    order { create(:order) }
    user { order.user }
    type { %w[credit atm].sample }
    identifier { "xxxx-xxxx-xxxx-#{Faker::Number.between(0000, 9999)}" }

    trait(:paid) do
      after(:create) do |payment, _|
        payment.succeed!
        payment.update_attributes(paid_at: Time.zone.now)
      end
    end
  end
end
