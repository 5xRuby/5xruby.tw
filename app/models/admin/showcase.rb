# == Schema Information
#
# Table name: showcases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  link        :string(255)
#  image       :string(255)
#  is_online   :boolean          default(FALSE), not null
#  sort_id     :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Admin::Showcase < Showcase
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
