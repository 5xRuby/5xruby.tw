require 'spec_helper'

describe Permalinkable do
  before :all do
    class A; include Permalinkable; end
  end
  it '#next_permalink' do
    expect(A.next_permalink('rails-123')).to eq 'rails-124'
    expect(A.next_permalink('rails')).to eq 'rails-1'
  end
end