# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  has_many :courses

  # validation macros
  validates :name, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
