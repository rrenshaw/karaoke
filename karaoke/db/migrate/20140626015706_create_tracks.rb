class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :artist
      t.string :path

      t.timestamps
    end
  end
end
