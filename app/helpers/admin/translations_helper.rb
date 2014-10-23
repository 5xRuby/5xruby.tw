module Admin::TranslationsHelper
  def admin_translations_available_columns record
    available_models = Translation::AVAILABLE_MODELS[record.class]
    available_names = []

    available_models.each do |value|
      value.is_a?(Hash) ? available_names += value.keys : available_names << value
    end

    if available_models
      record.class.columns.select{ |column| available_names.include?(column.name.to_sym) }
    else
      string_types = %i[string text]
      record.class.columns.select{ |column| string_types.include?(column.type) }
    end
  end

  def admin_translations_edit_field f, record, column
    available_models = Translation::AVAILABLE_MODELS[record.class]
    hash = available_models.last.is_a?(Hash) ? available_models.last : {}
    case hash[column.name.to_sym]
    when :redactor then f.text_area(:text, class: :redactor)
    else column.type == :string ? f.text_field(:text) : f.text_area(:text, class: :'form-control')
    end
  end
end
