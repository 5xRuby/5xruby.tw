class Translation < ActiveRecord::Base
  MODELS = [Post, Course, Faq, Speaker]
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :translatable, polymorphic: true

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
