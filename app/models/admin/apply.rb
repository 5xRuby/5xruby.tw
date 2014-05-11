class Admin::Apply < Apply
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course
  belongs_to :stage
  belongs_to :schedule

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
