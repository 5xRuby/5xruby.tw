require 'rails_helper'

describe Permalinkable do
  it '#next_permalink' do
    expect(Permalinkable.next_permalink('rails-123')).to eq 'rails-124'
    expect(Permalinkable.next_permalink('rails')).to eq 'rails-1'
  end

  it 'works in active record' do
    expect(Post.new(permalink: 'rails-123').next_permalink).to eq 'rails-124'
    expect(Post.new(permalink: 'rails').next_permalink).to eq 'rails-1'
  end
end