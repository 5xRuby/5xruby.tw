# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#  courses_count  :integer          default(0), not null
#  is_highlighted :boolean          default(FALSE), not null
#  sort_id        :integer          default(0), not null
#  permalink      :string(255)      default("7b88591f"), not null
#

require 'spec_helper'

describe Admin::Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
