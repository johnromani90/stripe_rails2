FactoryGirl.define do
  factory :subscription do
    plan
    user
    stripe_key "MyString"
    status_id 1
  end
end
