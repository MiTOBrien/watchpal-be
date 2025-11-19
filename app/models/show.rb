class Show < ApplicationRecord
  belongs_to :user

  validates :name, :air_day, :air_time, :channel, presence: true
end