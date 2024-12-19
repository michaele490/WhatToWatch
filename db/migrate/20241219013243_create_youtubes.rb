class CreateYoutubes < ActiveRecord::Migration[7.2]
  def change
    create_table :youtubes do |t|
      t.integer :minutes
      t.string :channel
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
