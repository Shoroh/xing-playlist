class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  belongs_to :genre

  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  validates :title, :artist, :album, :genre, presence: true
end
