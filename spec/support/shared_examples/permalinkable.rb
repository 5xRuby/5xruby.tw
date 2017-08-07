# frozen_string_literal: true
require 'rails_helper'

RSpec.shared_examples "permalinkable" do |source_column, target_column|
  source_column ||= :name
  target_column ||= :permalink

  it { is_expected.to validate_presence_of(target_column) }
end
