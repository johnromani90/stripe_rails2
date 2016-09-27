class User < ApplicationRecord
  has_many :plans, through: :subscriptions
  before_destroy :delete_from_stripe


  attr_writer :stripe_card_token
  attr_accessor :selected_plan_id

  def add_to_stripe
    args = {email: email}
    stripe_customer = Stripe::Customer.create(args)
    self.stripe_key = stripe_customer.id
    self.save
  rescue => e
    errors.add(:stripe_key, "Customer can not be added to stripe. #{e.message}")
  end

  def self.retrieve_stripe_users(limit=nil)
    args = {limit: limit} if limit.present?
    Stripe::Customer.list(args)
  end

  def self.retrieve_stripe_user(id)
    Stripe::Customer.retrieve(id: id)
  end

private

  def delete_from_stripe
    Stripe::Customer.retrieve(id: stripe_key).delete
  rescue => e
    self.errors.add(:stripe_key, "Could not delete Stripe customer. #{e.message}")
  end
end
