require 'spec_helper'

describe "admin/speakers/new" do
  before(:each) do
    assign(:admin_speaker, stub_model(Admin::Speaker,
      :avatar => "MyString",
      :name => "MyString",
      :summary => "MyText",
      :is_online => false
    ).as_new_record)
  end

  it "renders new admin_speaker form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_speakers_path, "post" do
      assert_select "input#admin_speaker_avatar[name=?]", "admin_speaker[avatar]"
      assert_select "input#admin_speaker_name[name=?]", "admin_speaker[name]"
      assert_select "textarea#admin_speaker_summary[name=?]", "admin_speaker[summary]"
      assert_select "input#admin_speaker_is_online[name=?]", "admin_speaker[is_online]"
    end
  end
end
