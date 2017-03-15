class DatePickerInput < SimpleForm::Inputs::Base

  def input(wrapper_options = {})
    template.content_tag(:input, '', {
      value: object.send(attribute_name).strftime("%Y-%m-%d"),
      class: 'form-control datetimepicker',
      data: {
        'date-pickTime' => false,
        'date-format' => 'YYYY-MM-DD'
      }
    }.merge(wrapper_options))
  end
end
