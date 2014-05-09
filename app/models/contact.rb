class Contact
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :phone, :message
end