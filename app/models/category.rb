class Category < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  has_many :courses

  # validation macros
  validates :name, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
