class Show < ApplicationRecord
  belongs_to :user

  validates :show_name, :channel_name, presence: true
end