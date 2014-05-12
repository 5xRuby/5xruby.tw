# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  avatar     :string(255)
#  name       :string(255)      not null
#  summary    :text
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Admin::Speaker do
  pending "add some examples to (or delete) #{__FILE__}"
end
