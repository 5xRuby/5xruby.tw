class ArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if (value - options[:in]).length.zero?
    record.errors.add(attribute, :inclusion)
  end
end
