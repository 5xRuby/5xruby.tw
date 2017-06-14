class Admin::Activity < Activity
  self.inheritance_column = :_non_existing_column
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros
  has_and_belongs_to_many :courses, after_add: :touch_if_needed, after_remove: :touch_if_needed
  belongs_to :template, class_name: "Admin::CampTemplate", required: false
  belongs_to :survey, class_name: "Admin::Survey", required: false

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
