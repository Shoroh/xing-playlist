class Importers::Song < Importers::Base
  SONG_COLUMNS = [:title,	:interpret,	:album, :track, :year, :genre].freeze

  private

  def assign_from_row(row)
    song = ::Song.where(title: row[:title]).first_or_initialize
    song.assign_attributes(
      artist: association(Artist, row[:interpret]),
      album: association(Album, row[:album]),
      track: row[:track],
      year: row[:year],
      genre: association(Genre, row[:genre])
    )
    song
  end

  def association(klass, name)
    klass.find_or_create_by(name: name)
  end

  def columns
    SONG_COLUMNS
  end
end
