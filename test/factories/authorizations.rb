FactoryGirl.define do
  factory :authorization do
    provider "MyString"
    uid "MyString"
    token "MyString"
    refresh_token "MyString"
    expires_at "2016-08-14 14:32:10"
    user nil
  end
end
