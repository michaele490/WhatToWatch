class Youtube < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :channel, presence: true
  validates :minutes, presence: true

  def no_negative_values
    if minutes < 0
      errors.add(:base, "minutes cannot be negative")
    end
  end
end
