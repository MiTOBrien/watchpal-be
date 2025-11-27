class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :shows, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def subscribed?
    subscriptions.where(status: "active").exists?
  end

  def subscribed
    subscribed?
  end

  def subscription
    subscriptions.find_by(status: 'active')
  end

  def subscription_id
    subscriptions.find_by(status: %w[active canceling])&.stripe_subscription_id
  end
end
