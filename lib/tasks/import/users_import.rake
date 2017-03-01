namespace :import do
  desc 'Import Users from CSV file'
  task :users, [:path_to_file] => [:environment] do |t, args|
    args.with_defaults(path_to_file: File.join(Rails.root, 'spec/support/csv/users', 'valid_users.csv'))
    importer = Importers::User.new(args.path_to_file)
    importer.import
    puts importer.errors_messages if importer.has_error?
    puts "Imported #{importer.counter} users"
    puts 'See logs here for details —> log/import/users.log'
  end
end
