require 'rails_helper'

RSpec.describe "admin/videos/index", :type => :view do
  before(:each) do
    assign(:admin_videos, [
      Admin::Video.create!(
        :title => "Title",
        :link => "Link",
        :summary => "Summary",
        :description => "MyText",
        :is_online => false
      ),
      Admin::Video.create!(
        :title => "Title",
        :link => "Link",
        :summary => "Summary",
        :description => "MyText",
        :is_online => false
      )
    ])
  end

  it "renders a list of admin/videos" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
