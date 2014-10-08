require 'rails_helper'

RSpec.describe "admin/showcases/show", :type => :view do
  before(:each) do
    @admin_showcase = assign(:admin_showcase, Admin::Showcase.create!(
      :name => "Name",
      :description => "MyText",
      :link => "Link",
      :image => "Image",
      :is_online => false,
      :sort_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
  end
end
