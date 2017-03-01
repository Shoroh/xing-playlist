class Importers::Playlist < Importers::Base
  PLAYLIST_COLUMNS = [:user_id, :name, :mp3_ids].freeze

  private

  def assign_from_row(row)
    playlist = ::Playlist.where(name: row[:name]).first_or_initialize

    playlist.assign_attributes(
      user: user(row[:user_id]),
      songs: songs(row[:mp3_ids])
    )
    playlist
  end

  def songs(songs_ids)
    ::Song.where(id: songs_ids.split(',').map(&:to_i))
  end

  def user(user_id)
    ::User.find_by(id: user_id)
  end

  def columns
    PLAYLIST_COLUMNS
  end
end
