class JsonFormDataInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    json_data = object.send(options[:source])

    out = ActiveSupport::SafeBuffer.new
    json_data.each do |key, value|
      input_options = value.clone
      name = input_options.delete(:name)

      input_options.merge!(checked: object.send(name)) if value[:as] == 'radio_buttons'
      input_options.merge!(selected: object.send(name)) if value[:as] == 'check_boxes'
      input_options.merge!(include_blank: false) if value[:as] == 'select'
      out << @builder.input(name, input_options.symbolize_keys)
    end

    out
  end
end
