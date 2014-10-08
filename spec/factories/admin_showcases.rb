# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_showcase, :class => 'Admin::Showcase' do
    name "MyString"
    description "MyText"
    link "MyString"
    image "MyString"
    is_online false
    sort_id 1
  end
end
