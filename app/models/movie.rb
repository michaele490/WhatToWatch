class Movie < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :genre, presence: true
end
