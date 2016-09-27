class Plan < ApplicationRecord
  validates :name, :interval_id, presence: true

  before_create :add_to_stripe
  before_destroy :delete_from_stripe

  def add_to_stripe
    stripe_plan = Stripe::Plan.create(name: name, id: name, amount: (price * 100).to_i, interval: duration, currency: 'usd')
    self.stripe_key = stripe_plan.id
  rescue => e
    self.errors.add(:stripe_key, "Could not create Stripe plan. #{e.message}")
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def delete_from_stripe
    Stripe::Plan.retrieve(stripe_key).delete
  rescue => e
    self.errors.add(:stripe_key, "Could not delete Stripe plan. #{e.message}")
  end

  def duration
    PlanInterval.find(interval_id).duration
  end

  def self.retrieve_stripe_plans(limit=nil)
    args = {limit: limit} if limit.present?
    Stripe::Plan.list(args)
  end

  def self.retrieve_stripe_plan(id)
    stripe_plan = Stripe::Plan.retrieve(id: id)
  rescue
    raise
  end
end
