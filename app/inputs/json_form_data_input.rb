class JsonFormDataInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    json_form_data = object.send(options[:source])

    out = ActiveSupport::SafeBuffer.new
    json_form_data.each do |question|
      input_options = question.clone
      name = input_options.delete(:name)
      out << @builder.input(name, input_options)
    end

    out
  end
end
