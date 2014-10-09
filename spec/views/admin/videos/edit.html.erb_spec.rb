require 'rails_helper'

RSpec.describe "admin/videos/edit", :type => :view do
  before(:each) do
    @admin_video = assign(:admin_video, Admin::Video.create!(
      :title => "MyString",
      :link => "MyString",
      :summary => "MyString",
      :description => "MyText",
      :is_online => false
    ))
  end

  it "renders the edit admin_video form" do
    render

    assert_select "form[action=?][method=?]", admin_video_path(@admin_video), "post" do

      assert_select "input#admin_video_title[name=?]", "admin_video[title]"

      assert_select "input#admin_video_link[name=?]", "admin_video[link]"

      assert_select "input#admin_video_summary[name=?]", "admin_video[summary]"

      assert_select "textarea#admin_video_description[name=?]", "admin_video[description]"

      assert_select "input#admin_video_is_online[name=?]", "admin_video[is_online]"
    end
  end
end
