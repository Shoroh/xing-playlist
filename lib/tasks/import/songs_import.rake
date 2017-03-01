namespace :import do
  desc 'Import Songs from CSV file'
  task :songs, [:path_to_file] => [:environment] do |t, args|
    args.with_defaults(path_to_file: File.join(Rails.root, 'spec/support/csv/songs', 'valid_songs.csv'))
    importer = Importers::Song.new(args.path_to_file)
    importer.import
    puts importer.errors_messages if importer.has_error?
    puts "Imported #{importer.counter} songs"
    puts 'See logs here for details —> log/import_csv.log'
  end
end
