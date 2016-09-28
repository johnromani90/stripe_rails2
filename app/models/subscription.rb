class Subscription < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  before_validation :add_to_stripe, on: :create

  def add_to_stripe
    stripe_customer = Stripe::Customer.retrieve(user.stripe_key)
    # todo handle trial and handle start date
    stripe_subscription = stripe_customer.subscriptions.create(plan: plan.stripe_key)
    self.stripe_key = stripe_subscription.id
  rescue => e
    errors.add(:stripe_key, "Could not create Stripe subscription. #{e.message}")
  end

  def delete_from_stripe
    Stripe::Subscription.retrieve(stripe_key).delete
  rescue => e
    self.errors.add(:stripe_key, "Could not delete Stripe subscription. #{e.message}")
  end

  def self.retrieve_stripe_subscriptions(limit=nil)
    args = {limit: limit} if limit.present?
    Stripe::Subscription.list(args)
  end

  def self.retrieve_stripe_subscription(id)
    Stripe::Subscription.retrieve(id: id)
  end
end
