require 'rails_helper'

describe Permalinkable do
  it '#next_permalink' do
    expect(Permalinkable.next_permalink('rails-123')).to eq 'rails-124'
    expect(Permalinkable.next_permalink('rails')).to eq 'rails-1'
  end
end