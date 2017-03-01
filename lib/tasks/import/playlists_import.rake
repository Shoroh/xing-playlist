namespace :import do
  desc 'Import Playlists from CSV file'
  task :playlists, [:path_to_file] => [:environment] do |t, args|
    args.with_defaults(path_to_file: File.join(Rails.root, 'spec/support/csv/playlists', 'valid_playlists.csv'))
    importer = Importers::Playlist.new(args.path_to_file)
    importer.import
    puts importer.errors_messages if importer.has_error?
    puts "Imported #{importer.counter} playlists"
    puts 'See logs here for details —> log/import_csv.log'
  end
end
