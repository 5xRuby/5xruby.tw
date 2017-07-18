class Survey < ApplicationRecord
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  serialize :questions, HashSerializer

  # association macros
  has_many :activities

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
