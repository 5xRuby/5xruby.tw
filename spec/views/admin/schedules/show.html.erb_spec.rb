require 'spec_helper'

describe "admin/schedules/show" do
  before(:each) do
    @admin_schedule = assign(:admin_schedule, stub_model(Admin::Schedule,
      :stage => nil,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
