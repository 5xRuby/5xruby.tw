# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  iframe      :string(255)
#  summary     :string(255)
#  description :text
#  is_online   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Admin::Video, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
