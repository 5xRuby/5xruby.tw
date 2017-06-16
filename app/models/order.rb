# frozen_string_literal: true

class Order < ApplicationRecord
  # scope macros

  # Concerns macros
  include AASM

  # Constants
  STATE = { 'pending': 'pending',
            'success': 'success',
            'expired': 'expired' }.freeze

  # Attributes related macros
  enum state: STATE

  aasm column: :state, no_direct_assignment: true, enum: true do
    state :pending, initial: true
    state :success, :expired

    event :succeed! do
      transitions from: :pending, to: :success
    end

    event :expire! do
      transitions from: :pending, to: :expired
    end
  end

  delegate :survey, to: :purchasable

  # association macros
  belongs_to :user
  belongs_to :purchasable, polymorphic: true

  # validation macros
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  # callbacks

  # other

  protected
  # callback methods
end
