class Stage < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course

  # validation macros
  validates :title, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
