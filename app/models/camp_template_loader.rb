class CampTemplateLoader < ActiveSupport::HashWithIndifferentAccess
  @@source = YAML.load_file(Rails.root.join('config', 'camp.yml'))
  cattr_reader :source

  def initialize(template = self.class.source.with_indifferent_access)
    case template
    when NilClass
      raise RuntimeError, "no camp template yaml file given"
    when CampTemplate
      self.update(template.payload)
    else
      self.update(template)
    end
  end
end
