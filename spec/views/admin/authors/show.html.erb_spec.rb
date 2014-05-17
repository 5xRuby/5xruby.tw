require 'spec_helper'

describe "admin/authors/show" do
  before(:each) do
    @admin_author = assign(:admin_author, stub_model(Admin::Author,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
