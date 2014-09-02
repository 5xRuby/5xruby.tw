# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text             not null
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#  author_id  :integer
#  summary    :text
#  is_online  :boolean          default(FALSE), not null
#  permalink  :string(255)      not null
#  publish_at :datetime
#

class Admin::Post < Post
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :author

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
