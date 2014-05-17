require 'spec_helper'

describe "admin/faqs/show" do
  before(:each) do
    @admin_faq = assign(:admin_faq, stub_model(Admin::Faq,
      :question => "MyText",
      :answer => "MyText",
      :is_online => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
