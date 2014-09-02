# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#  courses_count  :integer          default(0), not null
#  is_highlighted :boolean          default(FALSE), not null
#  sort_id        :integer          default(0), not null
#  permalink      :string(255)      not null
#

class Category < ActiveRecord::Base
  # scope macros

  # Concerns macros
  include Permalinkable

  # Constants
  
  # Attributes related macros
  permalinkable

  # association macros
  has_many :courses

  # validation macros
  validates :name, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
