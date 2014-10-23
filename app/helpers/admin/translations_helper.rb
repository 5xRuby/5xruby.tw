module Admin::TranslationsHelper
  def admin_translations_edit_field f, column
    column.type == :string ? f.text_field(:text) : f.text_area(:text, class: 'redactor')
  end
end
