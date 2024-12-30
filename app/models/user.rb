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
      "#{hours} hr#{'s' if hours > 1} #{minutes} min#{'s' if minutes > 1}"
    elsif hours > 0
      "#{hours} hr#{'s' if hours > 1}"
    elsif minutes > 0
      "#{minutes} min#{'s' if minutes > 1}"
    else
      "0 mins"
    end
  end

  def average_time
    if youtubes.count > 0
      avg = total_minutes / youtubes.count
      if avg >= 60
        "#{avg / 60} hr#{'s' if avg >= 120} #{avg % 60} min#{'s' if avg % 60 > 1}"
      elsif avg < 60
        "#{avg} min#{'s' if avg > 1}"
      end
    else
      0
    end
  end
end
