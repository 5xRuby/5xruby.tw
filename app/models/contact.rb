class Contact
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :phone, :message
  validates :first_name, :last_name, :email, :phone, :message, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
end