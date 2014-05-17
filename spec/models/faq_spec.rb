# == Schema Information
#
# Table name: faqs
#
#  id         :integer          not null, primary key
#  question   :text             not null
#  answer     :text             not null
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Faq do
  pending "add some examples to (or delete) #{__FILE__}"
end
