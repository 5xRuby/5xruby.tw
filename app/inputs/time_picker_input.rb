class TimePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options = {})
    template.content_tag(:input, '', {
      value: object.send(attribute_name).strftime("%H:%M"),
      class: 'form-control datetimepicker',
      data: {
        'date-pickDate' => false,
        'date-format' => 'HH:mm'
      }
    }.merge(wrapper_options))
  end
end
