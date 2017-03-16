class DatePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options = {})
    input_html_classes.push('form-control', 'datetimepicker')
    @builder.text_field(attribute_name, {
      value: object.send(attribute_name).strftime("%Y-%m-%d"),
      data: {
        'date-pickTime' => false,
        'date-format' => 'YYYY-MM-DD'
      }
    }.merge(input_html_options).merge(wrapper_options))
  end
end
