require 'rails_helper'

RSpec.describe "admin/showcases/new", :type => :view do
  before(:each) do
    assign(:admin_showcase, Admin::Showcase.new(
      :name => "MyString",
      :description => "MyText",
      :link => "MyString",
      :image => "MyString",
      :is_online => false,
      :sort_id => 1
    ))
  end

  it "renders new admin_showcase form" do
    render

    assert_select "form[action=?][method=?]", admin_showcases_path, "post" do

      assert_select "input#admin_showcase_name[name=?]", "admin_showcase[name]"

      assert_select "textarea#admin_showcase_description[name=?]", "admin_showcase[description]"

      assert_select "input#admin_showcase_link[name=?]", "admin_showcase[link]"

      assert_select "input#admin_showcase_image[name=?]", "admin_showcase[image]"

      assert_select "input#admin_showcase_is_online[name=?]", "admin_showcase[is_online]"

      assert_select "input#admin_showcase_sort_id[name=?]", "admin_showcase[sort_id]"
    end
  end
end
