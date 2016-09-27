require 'rails_helper'

RSpec.describe Plan, type: :model do

  context 'when plan exists in stripe' do

  end

  context 'when plan does not exists in stripe' do
    before :each do
      @plan = FactoryGirl.create(:plan)
    end

    it 'adds plan to stripe', :vcr do
      last_plan = Plan.retrieve_stripe_plans(1).first
      expect(last_plan).to be_present
      expect(last_plan.id).to eq @plan.stripe_key
    end
  end
end
