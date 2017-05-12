class CampTemplate < ApplicationRecord

  def initialize(_ = {})
    super
    self.payload ||= CampTemplateLoader.new
  end

  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  def json
    self.payload.to_json
  end

  def json=(input)
    self.payload = JSON.parse(input)
  end

  # association macros
  has_many :camps, class_name: "Activity::Camp", foreign_key: :template_id

  # validation macros
  validates :title, presence: true

  # callbacks
  # other

  protected
  # callback methods
end
