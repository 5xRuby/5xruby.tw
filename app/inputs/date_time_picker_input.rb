class DateTimePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options = {})
    input_html_classes.push('form-control', 'datetimepicker')
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.text_field(attribute_name, {
      value: (object.send(attribute_name) || Time.zone.now).strftime("%Y-%m-%d %H:%M"),
      data: {
        'date-pickTime' => true,
        'date-format' => 'YYYY-MM-DD HH:mm'
      }
    }.merge(merged_input_options))
  end
end
