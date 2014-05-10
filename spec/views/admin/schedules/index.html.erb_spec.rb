require 'spec_helper'

describe "admin/schedules/index" do
  before(:each) do
    assign(:admin_schedules, [
      stub_model(Admin::Schedule,
        :stage => nil,
        :description => "MyText"
      ),
      stub_model(Admin::Schedule,
        :stage => nil,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of admin/schedules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
