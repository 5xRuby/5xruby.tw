# == Schema Information
#
# Table name: stages
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  date        :date             default(Wed, 03 Sep 2014), not null
#  start_at    :time             default(2000-01-01 00:00:00 UTC), not null
#  end_at      :time             default(2000-01-01 00:00:00 UTC), not null
#  hours       :float            default(1.0), not null
#

class Stage < ActiveRecord::Base
  # scope macros

  # Concerns macros
  include Select2Concern

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :course

  # validation macros
  validates :title, :date, :start_at, :end_at, :hours, presence: true
  select2_white_list :title

  # callbacks
  after_initialize :set_defualt_values, if: :new_record?, unless: :changed?

  # other

  protected
  # callback methods
  def set_defualt_values
    self.date = Time.now.strftime('%Y-%m-%d')
    self.start_at = '09:30'
    self.end_at = '17:00'
  end
end
