class Plan < ApplicationRecord
  validates :name, :interval_id, presence: true

  before_create :add_to_stripe

  def add_to_stripe
    stripe_plan = Stripe::Plan.create(name: name, id: name, amount: (price * 100).to_i, interval: duration, currency: 'usd')
    self.stripe_key = stripe_plan.id
  rescue => e
    self.errors.add(:stripe_key, "Could not create Stripe plan. #{e.message}")
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def duration
    PlanInterval.find(interval_id).duration
  end

  def self.retrieve_stripe_plans(limit=nil)
    args = {limit: limit} if limit.present?
    Stripe::Plan.list(args)
  end
end
