class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.references :artist, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true
      t.integer :track
      t.integer :year
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
