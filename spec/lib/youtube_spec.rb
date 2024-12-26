require 'rails_helper'

RSpec.describe Youtube, type: :model do
    describe '#no_negative_values' do
      it 'adds an error if minutes is negative' do
        youtube = Youtube.new(minutes: -1)
        youtube.no_negative_values
        expect(youtube.errors[:base]).to include("minutes cannot be negative")
      end
    end
end
