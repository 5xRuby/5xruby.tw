require 'spec_helper'

describe "admin/speakers/index" do
  before(:each) do
    assign(:admin_speakers, [
      stub_model(Admin::Speaker,
        :avatar => "Avatar",
        :name => "Name",
        :summary => "MyText",
        :is_online => false
      ),
      stub_model(Admin::Speaker,
        :avatar => "Avatar",
        :name => "Name",
        :summary => "MyText",
        :is_online => false
      )
    ])
  end

  it "renders a list of admin/speakers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
