module CsvSeeder
  def self.import_all
    import_users
    import_songs
    import_playlists
  end

  def self.import_users
    user_file = File.join(Rails.root, 'the_task/csv', 'user_data.csv')
    importer = Importers::User.new(user_file)
    import!(importer)
  end

  def self.import_songs
    user_file = File.join(Rails.root, 'the_task/csv', 'mp3_data.csv')
    importer = Importers::Song.new(user_file)
    import!(importer)
  end

  def self.import_playlists
    user_file = File.join(Rails.root, 'the_task/csv', 'playlist_data.csv')
    importer = Importers::Playlist.new(user_file)
    import!(importer)
  end

  def self.import!(importer)
    puts "Import started for #{importer.class}"
    importer.import
    puts importer.errors_messages if importer.has_error?
    puts "Imported #{importer.counter} records"
  end

  class << self
    private :import!
  end
end
