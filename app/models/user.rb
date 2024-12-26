class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  has_many :movies, dependent: :destroy
  has_many :youtubes, dependent: :destroy
  has_many :tv_shows, dependent: :destroy

  def total_minutes
    youtubes.sum(:minutes)
  end

  def total_time
    total_minutes = self.total_minutes
    hours = total_minutes / 60
    minutes = total_minutes % 60

    if hours > 0 && minutes > 0
      "#{hours} hrs #{minutes} mins"
    elsif hours > 0
      "#{hours} hrs"
    else
      "#{minutes} mins"
    end
  end

  def average_minutes
    if youtubes.count > 0
      total_minutes / youtubes.count
    else
      0
    end
  end
end
