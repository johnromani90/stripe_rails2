require 'rails_helper'
RSpec.describe User, type: :model do
  context 'exists in stripe' do
    before :each do
      StripeMock.start
      @user = FactoryGirl.create(:user)
    end
    after { StripeMock.stop }

    it 'deletes from local db' do
      expect{@user.destroy}.to change{User.count}.by -1
    end

    it 'deletes from stripe' do
      @user.add_to_stripe
      expect(User.retrieve_stripe_user(@user.stripe_key).id).to eq @user.stripe_key
      @user.destroy
      expect(User.retrieve_stripe_user(@user.stripe_key).deleted).to be true
    end

  end

  context 'does not exist in stripe' do
    before :each do
      StripeMock.start
      @plan = FactoryGirl.create(:plan)
      @user = FactoryGirl.create(:valid_card_user, selected_plan_id: @plan.id)
      @user.add_to_stripe
    end
    after { StripeMock.stop }

    it 'adds to stripe' do
      last_user = User.retrieve_stripe_users(1).first
      expect(last_user).to be_present
      expect(last_user.id).to eq @user.stripe_key
    end

    it 'adds user and subscription to stripe' do
      @user.subscribe
      stripe_customer = User.retrieve_stripe_user(@user.stripe_key)
      stripe_subscription = Subscription.retrieve_stripe_subscription(@user.subscription.stripe_key)
      expect(stripe_customer.id).to eq @user.stripe_key
      expect(stripe_subscription.id).to eq @user.subscription.stripe_key
    end

  end
end
