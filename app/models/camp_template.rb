class CampTemplate < ApplicationRecord

  def initialize(_ = {})
    super
    self.payload = self.payload.presence || CampTemplateLoader.new
  end

  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  serialize :payload, HashSerializer

  # association macros
  has_many :camps, class_name: "Activity::Camp", foreign_key: :template_id

  # validation macros
  validates :title, presence: true

  # callbacks

  # other

  protected
  # callback methods
  before_destroy ->(template) { template.camps.clear }
end
