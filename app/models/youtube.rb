class Youtube < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :channel, presence: true
  validates :duration, presence: true
end
