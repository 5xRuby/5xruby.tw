# == Schema Information
#
# Table name: applies
#
#  id          :integer          not null, primary key
#  course_id   :integer
#  stage_id    :integer
#  schedule_id :integer
#  first_name  :string(255)      not null
#  last_name   :string(255)      not null
#  phone       :string(255)
#  email       :string(255)      not null
#  age         :integer
#  gender      :string(255)
#  message     :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Apply < ActiveRecord::Base
  # scope macros

  # Concerns macros
  extend Enumerize

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course
  belongs_to :stage
  belongs_to :schedule

  # validation macros
  enumerize :gender, in: %i[male female]
  validates :first_name, :last_name, :email, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
