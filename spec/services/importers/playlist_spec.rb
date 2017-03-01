require 'rails_helper'

describe Importers::Playlist do
  subject { Importers::Playlist }

  song_ids = %w(832 84 419 637 83 441 854 793 553 630 488 203 299 309 1047 733 170)
  song_ids.each do |song_id|
    let!("song_#{song_id}".to_sym) { create(:song, id: song_id) }
  end
  let!(:user) { create(:user, id: 1) }

  context 'cvs file is valid' do
    let(:valid_playlists) { File.join(Rails.root, 'spec/support/csv/playlists', 'valid_playlists.csv') }

    it 'imports new playlists from the file' do
      importer = subject.new(valid_playlists)
      importer.import
      songs = Playlist.find_by(name: '1_playlist_1').songs

      expect(importer.has_error?).to be_falsey
      expect(Playlist.count).to eq(10)
      expect(songs.ids).to match_array(song_ids.map(&:to_i))
    end
  end

  context 'csv file is not valid' do
    let(:not_uniq_playlists) do
      File.join(Rails.root, 'spec/support/csv/playlists', 'not_uniq_playlists.csv')
    end

    let(:wrong_columns_songs) do
      File.join(Rails.root, 'spec/support/csv/playlists', 'wrong_columns_playlists.csv')
    end

    let(:invalid_playlists) do
      File.join(Rails.root, 'spec/support/csv/playlists', 'invalid_playlists.csv')
    end

    it 'imports only 5 new playlists from the file, skips doubles' do
      expect { subject.new(not_uniq_playlists).import }.to change(Playlist, :count).by(5)
    end

    it 'got errors when csv file has wrong columns' do
      importer = subject.new(wrong_columns_songs)
      importer.import
      expect(importer.has_error?).to be_truthy
      expect(importer.errors_messages).to include('File is invalid, check the columns!')
    end

    it 'got errors when csv file has invalid data' do
      importer = subject.new(invalid_playlists)
      importer.import
      expect(importer.has_error?).to be_truthy
      expect(importer.errors_messages).to include("Record #1 — User can't be blank")
      expect(importer.errors_messages).to include("Record #2 — Name can't be blank")
      expect(importer.errors_messages).to include("Record #3 — Name is too long (maximum is 200 characters)")
    end
  end
end
