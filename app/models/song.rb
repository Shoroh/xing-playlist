class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  belongs_to :genre

  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  validates :title, :artist, :album, :genre, presence: true
  validates :title, length: { maximum: 200 }
  validates :year, numericality: { greater_than: 1900, less_than: 2100 }
  validates :track, numericality: { greater_than: 0, less_than: 1_000 }
end
