class Contact
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :phone, :message, :price
  validates :first_name, :last_name, :email, :phone, :message, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :price, numericality: true
end
