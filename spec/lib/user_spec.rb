require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(email: 'test@example.com', username: 'test_user', password: 'password') }

  before do
    Youtube.create(user: user, title: 'Video 1', channel: 'Channel A', minutes: 30)
    Youtube.create(user: user, title: 'Video 2', channel: 'Channel B', minutes: 45)
    Youtube.create(user: user, title: 'Video 3', channel: 'Channel C', minutes: 120)
  end

  describe '#total_minutes' do
    it 'returns the total watch time in minutes for all Youtube records belonging to the user' do
      expect(user.total_minutes).to eq(195)
    end
  end

  describe '#total_time' do
    it 'returns the total watch time in hours and minutes for all Youtube records belonging to the user' do
      expect(user.total_time).to eq('3 hrs 15 mins')
    end

    it 'returns only minutes if total_minutes is less than 60' do
      new_user = User.create(email: 'new_user@example.com', username:  'new_user', password: 'password')
      Youtube.create(user: new_user, title: 'Less than 1 hr', channel: 'Short content', minutes: 45)

      expect(new_user.total_time).to eq('45 mins')
    end

    it 'returns hours only when total_minutes is a multiple of 60' do
      new_user2 = User.create(email: 'new_user2@example.com', username: 'new_user2', password: 'password')
      Youtube.create(user: new_user2, title: 'Basically a movie', channel: 'Long content', minutes: 180)

      expect(new_user2.total_time).to eq('3 hrs')
    end
  end
end
