require 'spec_helper'

describe "admin/speakers/edit" do
  before(:each) do
    @admin_speaker = assign(:admin_speaker, stub_model(Admin::Speaker,
      :avatar => "MyString",
      :name => "MyString",
      :summary => "MyText",
      :is_online => false
    ))
  end

  it "renders the edit admin_speaker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_speaker_path(@admin_speaker), "post" do
      assert_select "input#admin_speaker_avatar[name=?]", "admin_speaker[avatar]"
      assert_select "input#admin_speaker_name[name=?]", "admin_speaker[name]"
      assert_select "textarea#admin_speaker_summary[name=?]", "admin_speaker[summary]"
      assert_select "input#admin_speaker_is_online[name=?]", "admin_speaker[is_online]"
    end
  end
end
