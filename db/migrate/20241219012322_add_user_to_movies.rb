class AddUserToMovies < ActiveRecord::Migration[7.2]
  def change
    add_reference :movies, :user, null: false, foreign_key: true
  end
end
