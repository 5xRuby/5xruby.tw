class Contact
  include ActiveModel::Model

  attr_accessor :name, :email, :phone, :message, :price
  validates :name, :email, :phone, :message, :price, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
end
