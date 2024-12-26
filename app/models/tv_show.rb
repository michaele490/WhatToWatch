class TvShow < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :minutesPerEpisode, presence: true
  validates :seasonsCompleted, presence: true
  validates :seasons, presence: true

  def seasons_completed_cannot_exceed_seasons
    if seasonsCompleted.present? && seasons.present? && seasonsCompleted > seasons
      errors.add(:seasonsCompleted, "seasons completed cannot exceed seasons")
    end
  end

  def seasons_left
    seasonsLeft =seasons - seasonsCompleted
  end

  def no_negative_values
    if minutesPerEpisode.present? && minutesPerEpisode <= 0
      errors.add(:base, "minutes per episode cannot be negative or zero")
    end

    if seasons.present? && seasons <= 0
      errors.add(:base, "seasons cannot be negative or zero")
    end

    if seasonsCompleted.present? && seasonsCompleted < 0
      errors.add(:base, "seasons completed cannot be negative")
    end
  end
end
