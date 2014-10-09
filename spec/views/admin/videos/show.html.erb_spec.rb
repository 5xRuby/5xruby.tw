require 'rails_helper'

RSpec.describe "admin/videos/show", :type => :view do
  before(:each) do
    @admin_video = assign(:admin_video, Admin::Video.create!(
      :title => "Title",
      :link => "Link",
      :summary => "Summary",
      :description => "MyText",
      :is_online => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Summary/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
