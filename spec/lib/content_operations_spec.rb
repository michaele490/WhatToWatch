require 'rails_helper'
require 'content_operations'

RSpec.describe ContentOperations do
  describe '.validate_seasons_completed' do
    it 'returns true if seasonsCompleted is less than or equal to seasons' do
      expect(ContentOperations.validate_seasons_completed(5, 3)).to be true
    end

    it 'returns false if seasonsCompleted is greater than seasons' do
      expect(ContentOperations.validate_seasons_completed(5, 6)).to be false
    end
  end

  describe '.sort_youtube_videos' do
    let(:youtubes) do
      [
        OpenStruct.new(minutes: 10),
        OpenStruct.new(minutes: 5),
        OpenStruct.new(minutes: 15)
      ]
    end

    it 'sorts YouTube videos in ascending order' do
      sorted_youtubes = ContentOperations.sort_youtube_videos(youtubes, :asc)
      expect(sorted_youtubes.map(&:minutes)).to eq([ 5, 10, 15 ])
    end

    it 'sorts YouTube videos in descending order' do
      sorted_youtubes = ContentOperations.sort_youtube_videos(youtubes, :desc)
      expect(sorted_youtubes.map(&:minutes)).to eq([ 15, 10, 5 ])
    end
  end

  describe '.average_video_duration' do
    let(:youtubes) do
      [
        OpenStruct.new(minutes: 10),
        OpenStruct.new(minutes: 20),
        OpenStruct.new(minutes: 30)
      ]
    end

    it 'calculates the average duration of videos' do
      expect(ContentOperations.average_video_duration(youtubes)).to eq(20.0)
    end
  end
end
