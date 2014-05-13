# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  schedule_id :integer          not null
#  speaker_id  :integer
#  start_at    :time             not null
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  belongs_to :schedule
  belongs_to :speaker

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
