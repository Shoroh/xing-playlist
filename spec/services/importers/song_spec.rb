require 'rails_helper'

describe Importers::Song do
  subject { Importers::Song }

  context 'cvs file is valid' do
    let(:valid_songs_csv_file) { File.join(Rails.root, 'spec/support/csv/songs', 'valid_songs.csv') }

    it 'imports new users from the file' do
      importer = subject.new(valid_songs_csv_file)
      importer.import
      expect(importer.has_error?).to be_falsey
      expect(Song.count).to eq(10)
      expect(Artist.count).to eq(2)
      expect(Album.count).to eq(2)
      expect(Genre.count).to eq(2)
    end
  end

  context 'csv file is not valid' do
    let(:not_uniq_songs) do
      File.join(Rails.root, 'spec/support/csv/songs', 'not_uniq_songs.csv')
    end

    let(:wrong_columns_songs) do
      File.join(Rails.root, 'spec/support/csv/songs', 'wrong_columns_songs.csv')
    end

    let(:invalid_songs) do
      File.join(Rails.root, 'spec/support/csv/songs', 'invalid_songs.csv')
    end

    it 'imports only 5 new songs from the file, skips doubles' do
      expect { subject.new(not_uniq_songs).import }.to change(Song, :count).by(5)
    end

    it 'got errors when csv file has wrong columns' do
      importer = subject.new(wrong_columns_songs)
      importer.import
      expect(importer.has_error?).to be_truthy
      expect(importer.errors_messages).to include('File is invalid, check the columns!')
    end

    it 'got errors when csv file has invalid data' do
      importer = subject.new(invalid_songs)
      importer.import
      expect(importer.has_error?).to be_truthy
      expect(importer.errors_messages).to include('Record #1 — Year must be less than 2100')
      expect(importer.errors_messages).to include('Record #2 — Year must be greater than 1900 and Track must be greater than 0')
      expect(importer.errors_messages).to include('Record #3 — Title is too long (maximum is 200 characters) and Track must be less than 1000')
    end
  end
end
