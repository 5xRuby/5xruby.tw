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

require 'spec_helper'

describe Admin::Schedule do
  pending "add some examples to (or delete) #{__FILE__}"
end
