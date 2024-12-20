class TvShow < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :minutesPerEpisode, presence: true
  validates :seasonsCompleted, presence: true
  validates :seasons, presence: true
end
