class Subscription < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  def add_to_stripe
    stripe_customer = Stripe::Customer.retrieve(user.stripe_key)
    # todo handle trial
    stripe_subscription = stripe_customer.subscriptions.create(plan: plan.stripe_key)
    self.stripe_key = stripe_subscription.id
    self.save
  rescue => e
    errors.add(:stripe_key, "Could not create Stripe subscription. #{e.message}")
  end

  def self.retrieve_stripe_subscriptions(limit=nil)
    args = {limit: limit} if limit.present?
    Stripe::Subscription.list(args)
  end
end
