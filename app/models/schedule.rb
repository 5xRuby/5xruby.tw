# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  stage_id    :integer          not null
#  date        :date             not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Schedule < ActiveRecord::Base
  # scope macros
  scope :available, -> { order(:date).where('date > ?', Time.now).includes(stage: :course).where(courses: {is_online: true}) }

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :stage
  has_many :events, -> { order(:start_at) }, dependent: :destroy
  accepts_nested_attributes_for :events, allow_destroy: true, reject_if: proc { |attributes| attributes[:title].blank? }
  has_many :applies

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
