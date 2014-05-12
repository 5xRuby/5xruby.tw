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

require 'spec_helper'

describe Admin::Apply do
  pending "add some examples to (or delete) #{__FILE__}"
end
