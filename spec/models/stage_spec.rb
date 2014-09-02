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
#  duration    :float            default(0.0), not null
#  date        :date             default(Tue, 02 Sep 2014), not null
#  start_at    :time             default(2000-01-01 20:52:59 UTC), not null
#  end_at      :time             default(2000-01-01 21:52:59 UTC), not null
#

require 'spec_helper'

describe Stage do
  pending "add some examples to (or delete) #{__FILE__}"
end
