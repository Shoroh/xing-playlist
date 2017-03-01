class CreatePlaylistSongs < ActiveRecord::Migration
  def change
    create_table :playlist_songs do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
