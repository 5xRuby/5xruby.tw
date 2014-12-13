class Faq < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros
  has_many :translations, as: :translatable

  # validation macros
  validates :question, uniqueness: true

  # callbacks

  # other
end
