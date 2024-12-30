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

    it 'returns 1 hr when total_minutes is exactly 60' do
      new_user3 = User.create(email: 'new_user3@example.com', username: 'new_user3', password: 'password')
      Youtube.create(user: new_user3, title: 'Just an hour', channel: 'Medium content', minutes: 60)

      expect(new_user3.total_time).to eq('1 hr')
    end

    it 'returns 1 hr and minutes when total_minutes is more than 60 but less than 120' do
      new_user4 = User.create(email: 'new_user4@example.com', username: 'new_user4', password: 'password')
      Youtube.create(user: new_user4, title: 'More than an hour', channel: 'Medium content', minutes: 94)

      expect(new_user4.total_time).to eq('1 hr 34 mins')
    end

    it 'returns 1 min if minutes is 1' do
      new_user5 = User.create(email: 'new_user5@example.com', username: 'new_user5', password: 'password')
      Youtube.create(user: new_user5, title: '61 minutes', channel: 'six_o_one_news', minutes: 61)

      expect(new_user5.total_time).to eq('1 hr 1 min')
    end
  end

  describe '#average_time' do
    it "returns the average watch time for all Youtube records belonging to the user using 'num hr num mins'" do
      expect(user.average_time).to eq('1 hr 5 mins')
    end

    it 'returns only minutes if the average is less than 60' do
      new_user = User.create(email: 'new_user@example.com', username: 'new_user', password: 'password')
      Youtube.create(user: new_user, title: 'documentary', channel: 'Mike productions', minutes: 45)
      expect(new_user.average_time).to eq('45 mins')
    end

    it "returns 'min' if the average time modulo 60 is 1" do
      new_user6 = User.create(email: 'new_user6@example.com', username: 'new_user6', password: 'password')
      Youtube.create(user: new_user6, title: '3 hour video', channel: 'very long videos', minutes: 181)

      expect(new_user6.average_time).to eq('3 hrs 1 min')
    end

    it 'returns 0 if the user has no Youtube records' do
      new_user3 = User.create(email: 'new_user3@example.com', username: 'new_user3', password: 'password')

      expect(new_user3.average_time).to eq(0)
    end
  end
end
