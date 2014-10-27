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

  def admin_translations_disabled_field record, column
    value = record.send(column.name)
    available_models = Translation::AVAILABLE_MODELS[record.class]
    hash = available_models.last.is_a?(Hash) ? available_models.last : {}
    case hash[column.name.to_sym]
    when :redactor then text_area_tag(nil, value, class: :redactor)
    when :string then text_field_tag(nil, value, class: :'form-control', disabled: true)
    when :text then text_area_tag(nil, value, rows: 5, class: :'form-control', disabled: true)
    else column.type == :string ? text_field_tag(nil, value, class: :'form-control', disabled: true) : text_area_tag(nil, value, rows: 5, class: :'form-control', disabled: true)
    end
  end

  def admin_translations_edit_field f, record, column
    available_models = Translation::AVAILABLE_MODELS[record.class]
    hash = available_models.last.is_a?(Hash) ? available_models.last : {}
    case hash[column.name.to_sym]
    when :redactor then f.text_area(:text, class: :redactor)
    when :string then f.text_field(:text, class: :'form-control')
    when :text then f.text_area(:text, rows: 5, class: :'form-control')
    else column.type == :string ? f.text_field(:text, class: :'form-control') : f.text_area(:text, rows: 5, class: :'form-control')
    end
  end

  def admin_translations_translation_object scope, record, column, locale
    scope.find{ |x| x.translatable == record && x.column == column.name && x.locale == locale } || Translation.new(translatable: record, column: column.name)
  end
end
