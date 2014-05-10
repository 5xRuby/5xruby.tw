class Schedule < ActiveRecord::Base
  # scope macros
  scope :available, -> { order(:date).where('date > ?', Time.now) }

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :stage

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
