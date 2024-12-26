require 'rails_helper'

RSpec.describe TvShow, type: :model do
  describe '#seasons_completed_cannot_exceed_seasons' do
    it 'adds an error if seasonsCompleted is greater than seasons' do
      tv_show = TvShow.new(seasons: 5, seasonsCompleted: 6)
      tv_show.seasons_completed_cannot_exceed_seasons
      expect(tv_show.errors[:seasonsCompleted]).to include("seasons completed cannot exceed seasons")
    end
  end

  describe '#seasons_left' do
    it 'returns the correct number of seasons left to watch' do
      tv_show = TvShow.new(seasons: 10, seasonsCompleted: 6)
      expect(tv_show.seasons_left).to eq(4)
    end

    it 'returns 0 if seasonsCompleted equals seasons' do
      tv_show = TvShow.new(seasons: 10, seasonsCompleted: 10)
      expect(tv_show.seasons_left).to eq(0)
    end
  end

  describe '#no_negative_values' do
    it 'adds an error if minutesPerEpisode is negative' do
      tv_show = TvShow.new(minutesPerEpisode: -1)
      tv_show.no_negative_values
      expect(tv_show.errors[:base]).to include("minutes per episode cannot be negative or zero")
    end

    it 'adds an error if seasons is negative' do
      tv_show = TvShow.new(seasons: -1)
      tv_show.no_negative_values
      expect(tv_show.errors[:base]).to include("seasons cannot be negative or zero")
    end

    it 'adds an error if seasonsCompleted is negative' do
      tv_show = TvShow.new(seasonsCompleted: -1)
      tv_show.no_negative_values
      expect(tv_show.errors[:base]).to include("seasons completed cannot be negative")
    end
  end
end
