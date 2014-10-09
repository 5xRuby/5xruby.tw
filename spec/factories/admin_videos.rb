# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_video, :class => 'Admin::Video' do
    title "MyString"
    link "MyString"
    summary "MyString"
    description "MyText"
    is_online false
  end
end
