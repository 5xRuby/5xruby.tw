class Activity < ApplicationRecord
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  has_and_belongs_to_many :courses, after_add: :touch_if_needed, after_remove: :touch_if_needed
  has_many :translations, as: :translatable

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
  def touch_if_needed(course)
    self.touch if persisted?
  end
end
