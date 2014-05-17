require 'spec_helper'

describe "admin/authors/new" do
  before(:each) do
    assign(:admin_author, stub_model(Admin::Author,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new admin_author form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_authors_path, "post" do
      assert_select "input#admin_author_name[name=?]", "admin_author[name]"
    end
  end
end
