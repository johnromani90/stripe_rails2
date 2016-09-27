require 'rails_helper'
require 'stripe_mock'

RSpec.describe Plan, type: :model do
  context 'when plan exists in stripe' do
    before :each do
      StripeMock.start
      @plan = FactoryGirl.create(:plan)
    end
    after { StripeMock.stop }
    it 'deletes from stripe', :live do
      expect(Plan.retrieve_stripe_plan(@plan.stripe_key).id).to eq @plan.stripe_key
      @plan.destroy
      expect{Plan.retrieve_stripe_plan(@plan.stripe_key)}.to raise_error(Stripe::InvalidRequestError)
    end

  end

  context 'when plan does not exists in stripe', :live do
    before :each do
      StripeMock.start
      @plan = FactoryGirl.create(:plan)
    end
    after { StripeMock.stop }

    it 'adds plan to stripe' do
      last_plan = Plan.retrieve_stripe_plans(1).first
      expect(last_plan).to be_present
      expect(last_plan.id).to eq @plan.stripe_key
    end
  end
end
