class AddTitleToTvShows < ActiveRecord::Migration[7.2]
  def change
    add_column :tv_shows, :title, :string
  end
end
