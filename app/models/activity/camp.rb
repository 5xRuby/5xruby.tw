class Activity::Camp < Activity
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros
  has_one :template, class_name: "CampTemplate", foreign_key: :activity_id

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
