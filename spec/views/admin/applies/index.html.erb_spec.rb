require 'spec_helper'

describe "admin/applies/index" do
  before(:each) do
    assign(:admin_applies, [
      stub_model(Admin::Apply,
        :course => nil,
        :stage => nil,
        :schedule => nil,
        :first_name => "First Name",
        :last_name => "Last Name",
        :phone => "Phone",
        :email => "Email",
        :age => 1,
        :gender => "Gender",
        :message => "MyText"
      ),
      stub_model(Admin::Apply,
        :course => nil,
        :stage => nil,
        :schedule => nil,
        :first_name => "First Name",
        :last_name => "Last Name",
        :phone => "Phone",
        :email => "Email",
        :age => 1,
        :gender => "Gender",
        :message => "MyText"
      )
    ])
  end

  it "renders a list of admin/applies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
