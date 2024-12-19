class TvShow < ApplicationRecord
  belongs_to :user

  validates :minutesPerEpisode, presence: true
  validates :seasonsComplete, presence: true
  validates :seasons, presence: true
end
