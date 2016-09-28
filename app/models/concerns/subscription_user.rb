module SubscriptionUser
  extend ActiveSupport::Concern

  included do
    has_many :plans, through: :subscriptions
    has_many :subscriptions, dependent: :destroy
    before_destroy :delete_from_stripe

    attr_accessor :stripe_card_token
    attr_accessor :selected_plan_id
  end



  module ClassMethods
    def retrieve_stripe_users(limit=nil)
      args = {limit: limit} if limit.present?
      Stripe::Customer.list(args)
    end

    def retrieve_stripe_user(id)
      Stripe::Customer.retrieve(id: id)
    end
  end

  #todo should this be in before create???
  def add_to_stripe
    args = {email: email, source: stripe_card_token}
    stripe_customer = Stripe::Customer.create(args)
    self.stripe_key = stripe_customer.id
    self.save
  rescue => e
    errors.add(:stripe_key, "Customer can not be added to stripe. #{e.message}")
  end

  def subscribe
    subscription = Subscription.create(user_id: id,
                                       plan_id: selected_plan_id,
                                       status_id: SubscriptionStatus.status_active.id
    )

  end

  def subscription
    self.subscriptions.first
  end

  private

  def delete_from_stripe
    Stripe::Customer.retrieve(id: stripe_key).delete
  rescue => e
    self.errors.add(:stripe_key, "Could not delete Stripe customer. #{e.message}")
  end
end
