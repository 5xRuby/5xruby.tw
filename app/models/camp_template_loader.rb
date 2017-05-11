class CampTemplateLoader < OpenStruct
  @@source = YAML.load_file(Rails.root.join('config', 'camp.yml'))
  cattr_reader :source

  def initialize(template = self.class.source)
    case template
    when NilClass
      raise RuntimeError, "no camp template yaml file given"
    when CampTemplate
      self.marshal_load(template.payload)
    else
      self.marshal_load(template)
    end
  end
end
