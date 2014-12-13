class InterviewQuestion < ActiveRecord::Base
  # scope macros
  scope :available, -> { where(is_online: true) }
  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros

  # validation macros

  # callbacks

  # other
end
