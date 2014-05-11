require 'spec_helper'

describe "admin/applies/show" do
  before(:each) do
    @admin_apply = assign(:admin_apply, stub_model(Admin::Apply,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Phone/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/Gender/)
    rendered.should match(/MyText/)
  end
end
