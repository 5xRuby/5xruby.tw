class TimePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options = {})
    input_html_classes.push('form-control', 'datetimepicker')
    @builder.text_field(attribute_name, {
      value: object.send(attribute_name).strftime("%H:%M"),
      data: {
        'date-pickDate' => false,
        'date-format' => 'HH:mm'
      }
    }.merge(input_html_options).merge(wrapper_options))
  end
end
