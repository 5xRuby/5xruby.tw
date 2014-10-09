require 'rails_helper'

RSpec.describe "admin/videos/new", :type => :view do
  before(:each) do
    assign(:admin_video, Admin::Video.new(
      :title => "MyString",
      :link => "MyString",
      :summary => "MyString",
      :description => "MyText",
      :is_online => false
    ))
  end

  it "renders new admin_video form" do
    render

    assert_select "form[action=?][method=?]", admin_videos_path, "post" do

      assert_select "input#admin_video_title[name=?]", "admin_video[title]"

      assert_select "input#admin_video_link[name=?]", "admin_video[link]"

      assert_select "input#admin_video_summary[name=?]", "admin_video[summary]"

      assert_select "textarea#admin_video_description[name=?]", "admin_video[description]"

      assert_select "input#admin_video_is_online[name=?]", "admin_video[is_online]"
    end
  end
end
