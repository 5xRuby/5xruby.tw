# == Schema Information
#
# Table name: translations
#
#  id                :integer          not null, primary key
#  translatable_id   :integer
#  translatable_type :string(255)
#  column            :string(255)
#  locale            :string(255)
#  text              :text
#  created_at        :datetime
#  updated_at        :datetime
#

class Translation < ActiveRecord::Base
  AVAILABLE_MODELS = {
    Faq      => [:question, :answer],
    Speaker  => [:name, :summary],
    Video    => [:title, :summary, description: :redactor],
    Showcase => [:name, :description],
    Post     => [:title, :summary, content: :redactor],
    Course   => [:title, :summary, :subtitle, what_will_learn: :redactor, description: :redactor, note: :redactor],
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

  protected
  # callback methods
end
