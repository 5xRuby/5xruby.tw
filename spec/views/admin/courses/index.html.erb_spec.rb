require 'spec_helper'

describe "admin/courses/index" do
  before(:each) do
    assign(:admin_courses, [
      stub_model(Admin::Course,
        :image => "Image",
        :title => "Title",
        :summary => "Summary",
        :description => "MyText",
        :what_will_learn => "MyText"
      ),
      stub_model(Admin::Course,
        :image => "Image",
        :title => "Title",
        :summary => "Summary",
        :description => "MyText",
        :what_will_learn => "MyText"
      )
    ])
  end

  it "renders a list of admin/courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
