class AddLinkToYoutube < ActiveRecord::Migration[7.2]
  def change
    add_column :youtubes, :link, :string
  end
end
