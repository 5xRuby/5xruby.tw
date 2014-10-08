require 'rails_helper'

RSpec.describe "admin/showcases/index", :type => :view do
  before(:each) do
    assign(:admin_showcases, [
      Admin::Showcase.create!(
        :name => "Name",
        :description => "MyText",
        :link => "Link",
        :image => "Image",
        :is_online => false,
        :sort_id => 1
      ),
      Admin::Showcase.create!(
        :name => "Name",
        :description => "MyText",
        :link => "Link",
        :image => "Image",
        :is_online => false,
        :sort_id => 1
      )
    ])
  end

  it "renders a list of admin/showcases" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
