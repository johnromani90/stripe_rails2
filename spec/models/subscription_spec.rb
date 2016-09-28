require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'exists in stripe' do
    before :each do
      StripeMock.start
      @plan = FactoryGirl.create(:plan)
      @user = FactoryGirl.create(:valid_card_user, selected_plan_id: @plan.id)
      @user.add_to_stripe
      @user.subscribe
    end

    after { StripeMock.stop }

    it 'matches our users subscription stripe key', :live do
      expect(Subscription.retrieve_stripe_subscription(@user.subscription.stripe_key).id).to eq @user.subscription.stripe_key
    end

    it 'deletes from stripe' do
      local_subscription = @user.subscription
      local_subscription.destroy
      expect{Subscription.retrieve_stripe_subscription(local_subscription.stripe_key)}.to raise_error(Stripe::InvalidRequestError)
    end
  end

  context 'does not exist in stripe' do
    before :each do
      StripeMock.start
    end
    after { StripeMock.stop }

    it 'adds to stripe' do
      @user = FactoryGirl.create(:user)
      @user.add_to_stripe
      subscription  = FactoryGirl.create(:subscription, user: @user)
      subscription.add_to_stripe
      last_subscription = Subscription.retrieve_stripe_subscriptions(1).first
      expect(last_subscription.id).to eq @subscription.stripe_key
    end

  end
end
