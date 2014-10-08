# == Schema Information
#
# Table name: showcases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  link        :string(255)
#  image       :string(255)
#  is_online   :boolean          default(FALSE), not null
#  sort_id     :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Admin::Showcase, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
