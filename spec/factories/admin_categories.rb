# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_category, :class => 'Admin::Category' do
    name "MyString"
  end
end
