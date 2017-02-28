class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  validates :name, presence: true
  validates :name, length: { maximum: 200 }
end
