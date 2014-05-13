# == Schema Information
#
# Table name: stages
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  title       :string(255)      not null
#  description :text
#  sort_id     :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#  duration    :float            default(0.0), not null
#

class Stage < ActiveRecord::Base
  # scope macros

  # Concerns macros
  include Select2Concern

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course
  has_many :schedules, -> { available }
  has_many :applies

  # validation macros
  validates :title, presence: true
  select2_white_list :title

  # callbacks

  # other

  protected
  # callback methods
end
