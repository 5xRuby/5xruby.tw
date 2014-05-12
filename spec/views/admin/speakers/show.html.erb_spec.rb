require 'spec_helper'

describe "admin/speakers/show" do
  before(:each) do
    @admin_speaker = assign(:admin_speaker, stub_model(Admin::Speaker,
      :avatar => "Avatar",
      :name => "Name",
      :summary => "MyText",
      :is_online => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Avatar/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
