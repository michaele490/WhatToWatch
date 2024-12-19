class AddGenreToTvShows < ActiveRecord::Migration[7.2]
  def change
    add_column :tv_shows, :genre, :string
  end
end
