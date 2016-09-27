FactoryGirl.define do
  factory :plan do
    name "MyString"
    stripe_key "MyString"
    price "9.99"
    interval 1
    description "MyText"
  end
end
