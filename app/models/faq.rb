# == Schema Information
#
# Table name: faqs
#
#  id         :integer          not null, primary key
#  question   :text             not null
#  answer     :text             not null
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#  sort_id    :integer          default(0), not null
#

class Faq < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  has_many :translations, as: :translatable

  # validation macros
  validates :question, uniqueness: true

  # callbacks

  # other

  protected
  # callback methods
end
