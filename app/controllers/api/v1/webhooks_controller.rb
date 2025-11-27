class Api::V1::WebhooksController < ApplicationController
  case event.type
  when 'checkout.session.completed'
    session = event.data.object
    user = User.find_by(email: session.customer_email)

    subscription = Stripe::Subscription.retrieve(session.subscription)

    Subscription.create!(
      user: user,
      stripe_subscription_id: subscription.id,
      stripe_price_id: subscription.items.first.price.id,
      status: subscription.status,
      current_period_start: Time.at(subscription.current_period_start),
      current_period_end: Time.at(subscription.current_period_end)
    )

  when 'customer.subscription.updated'
    subscription = event.data.object
    record = Subscription.find_by(stripe_subscription_id: subscription.id)
    record&.update(
      status: subscription.status,
      current_period_start: Time.at(subscription.current_period_start),
      current_period_end: Time.at(subscription.current_period_end)
    )

  when 'customer.subscription.deleted'
    subscription = event.data.object
    record = Subscription.find_by(stripe_subscription_id: subscription.id)
    record&.update(status: "canceled")
  end
end