# frozen_string_literal: true
class Payment < ApplicationRecord
  self.inheritance_column = :_type
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

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
