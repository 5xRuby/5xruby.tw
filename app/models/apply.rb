class Apply < ActiveRecord::Base
  # scope macros

  # Concerns macros
  extend Enumerize

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course
  belongs_to :stage
  belongs_to :schedule

  # validation macros
  enumerize :gender, in: %i[male female]

  # callbacks

  # other

  protected
  # callback methods
end
