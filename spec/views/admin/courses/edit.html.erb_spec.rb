require 'spec_helper'

describe "admin/courses/edit" do
  before(:each) do
    @admin_course = assign(:admin_course, stub_model(Admin::Course,
      :image => "MyString",
      :title => "MyString",
      :summary => "MyString",
      :description => "MyText",
      :what_will_learn => "MyText"
    ))
  end

  it "renders the edit admin_course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_course_path(@admin_course), "post" do
      assert_select "input#admin_course_image[name=?]", "admin_course[image]"
      assert_select "input#admin_course_title[name=?]", "admin_course[title]"
      assert_select "input#admin_course_summary[name=?]", "admin_course[summary]"
      assert_select "textarea#admin_course_description[name=?]", "admin_course[description]"
      assert_select "textarea#admin_course_what_will_learn[name=?]", "admin_course[what_will_learn]"
    end
  end
end
