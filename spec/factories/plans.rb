FactoryGirl.define do
  factory :plan do
    name "MyString"
    stripe_key "MyString"
    price "9.99"
    interval_id 1
    description "MyText"
  end
end
