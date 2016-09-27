require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'exists in stripe' do
    before :each do
      StripeMock.start
      @subscription = FactoryGirl.create(:subscription)
    end

    after { StripeMock.stop }

    it 'deletes from stripe' do

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
