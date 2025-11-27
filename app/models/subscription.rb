class Subscription < ApplicationRecord
  belongs_to :user

  enum status: {
    active: "active",
    canceled: "canceled",
    trialing: "trialing",
    incomplete: "incomplete"
  }
end