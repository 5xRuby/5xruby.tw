require 'spec_helper'

describe "admin/faqs/index" do
  before(:each) do
    assign(:admin_faqs, [
      stub_model(Admin::Faq,
        :question => "MyText",
        :answer => "MyText",
        :is_online => false
      ),
      stub_model(Admin::Faq,
        :question => "MyText",
        :answer => "MyText",
        :is_online => false
      )
    ])
  end

  it "renders a list of admin/faqs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
