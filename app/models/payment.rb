# frozen_string_literal: true

class Payment < ApplicationRecord
  # scope macros

  # Concerns macros
  include AASM

  # Constants
  STATE = { 'pending': 'pending',
            'success': 'success',
            'failed': 'failed' }.freeze

  # Attributes related macros
  enum state: STATE

  aasm column: :state, no_direct_assignment: true, enum: true do
    state :pending ,initial: true
    state :success, :failed

    event :succeed do
      transitions from: :pending, to: :success
    end

    event :fail do
      transitions from: :pending, to: :fail
    end
  end


  # association macros
  belongs_to :order
  belongs_to :user

  # validation macros
  validates :type, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
