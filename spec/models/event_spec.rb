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

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
