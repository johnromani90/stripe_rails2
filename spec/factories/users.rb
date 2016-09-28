FactoryGirl.define do
  factory :user do
    email "test@example.com"
    stripe_key "MyString"
    trait :valid_card do
      stripe_card_token {StripeMock::TestStrategies::Base.new.generate_card_token}
    end

    factory :valid_card_user, traits: [:valid_card]
  end
end
