class JsonFormFieldsEditorInput < SimpleForm::Inputs::Base

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(
      {
        name: ActionView::Helpers::Tags::Base.new(object_name, attribute_name, template).send(:tag_name),
        value: object.send(attribute_name)
      },
      merge_wrapper_options(input_html_options, wrapper_options)
    )

    @builder.template.react_component 'FormFieldsEditorInput', merged_input_options
  end
end
