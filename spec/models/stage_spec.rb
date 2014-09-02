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
#  date        :date
#  start_at    :time
#  end_at      :time
#

require 'spec_helper'

describe Stage do
  pending "add some examples to (or delete) #{__FILE__}"
end
