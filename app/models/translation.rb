class Translation < ActiveRecord::Base
  AVAILABLE_MODELS = {
    Faq      => [:question, :answer],
    Speaker  => [:name, :summary],
    Video    => [:title, :summary, description: :redactor],
    Showcase => [:name, :description],
    Post     => [:title, :summary, content: :redactor],
    Course   => [:title, :summary, :subtitle, what_will_learn: :redactor, note: :redactor],
    Activity => [:title],
    Stage    => [:title, description: :redactor]
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
end
