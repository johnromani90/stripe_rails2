FactoryGirl.define do
  factory :user do
    email "test@example.com"
    stripe_key "MyString"
    trait :valid_card do
      stripe_card_token {StripeMock::Client.generate_card_token}
    end
  end
end
