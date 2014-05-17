# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_author, :class => 'Admin::Author' do
    name "MyString"
  end
end
