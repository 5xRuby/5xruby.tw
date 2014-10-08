require 'rails_helper'

RSpec.describe "admin/showcases/edit", :type => :view do
  before(:each) do
    @admin_showcase = assign(:admin_showcase, Admin::Showcase.create!(
      :name => "MyString",
      :description => "MyText",
      :link => "MyString",
      :image => "MyString",
      :is_online => false,
      :sort_id => 1
    ))
  end

  it "renders the edit admin_showcase form" do
    render

    assert_select "form[action=?][method=?]", admin_showcase_path(@admin_showcase), "post" do

      assert_select "input#admin_showcase_name[name=?]", "admin_showcase[name]"

      assert_select "textarea#admin_showcase_description[name=?]", "admin_showcase[description]"

      assert_select "input#admin_showcase_link[name=?]", "admin_showcase[link]"

      assert_select "input#admin_showcase_image[name=?]", "admin_showcase[image]"

      assert_select "input#admin_showcase_is_online[name=?]", "admin_showcase[is_online]"

      assert_select "input#admin_showcase_sort_id[name=?]", "admin_showcase[sort_id]"
    end
  end
end
