class CreateTvShows < ActiveRecord::Migration[7.2]
  def change
    create_table :tv_shows do |t|
      t.integer :minutesPerEpisode
      t.integer :seasons
      t.integer :seasonsCompleted
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
