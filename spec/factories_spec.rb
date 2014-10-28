require 'rails_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'is valid' do
      expect(FactoryGirl.build(factory_name)).to be_valid
    end
  end
end
