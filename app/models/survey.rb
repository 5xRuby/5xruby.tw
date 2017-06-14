class Survey < ApplicationRecord
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  def fields_json
    self.fields.to_json
  end

  def fields_json=(input)
    self.fields = JSON.parse(input)
  end

  def fields_brief
    self.fields.map do |f|
      "#{f['label']} (#{f['as']})"
    end.join(', ')
  end

  # association macros
  has_many :activities

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
