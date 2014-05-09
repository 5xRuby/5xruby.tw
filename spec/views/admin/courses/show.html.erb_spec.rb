require 'spec_helper'

describe "admin/courses/show" do
  before(:each) do
    @admin_course = assign(:admin_course, stub_model(Admin::Course,
      :image => "Image",
      :title => "Title",
      :summary => "Summary",
      :description => "MyText",
      :what_will_learn => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image/)
    rendered.should match(/Title/)
    rendered.should match(/Summary/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
