class Translation < ActiveRecord::Base
  AVAILABLE_MODELS = {
    Post => [:title, :summary, content: :redactor],
    Course => [:title, :summary, :subtitle, what_will_learn: :redactor, description: :redactor, note: :redactor],
    Faq => [:question, :answer],
    Speaker => [:name, :summary, :title]
  }
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
