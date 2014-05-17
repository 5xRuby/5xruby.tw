require 'spec_helper'

describe "admin/authors/edit" do
  before(:each) do
    @admin_author = assign(:admin_author, stub_model(Admin::Author,
      :name => "MyString"
    ))
  end

  it "renders the edit admin_author form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_author_path(@admin_author), "post" do
      assert_select "input#admin_author_name[name=?]", "admin_author[name]"
    end
  end
end
