require 'rails_helper'

describe Importers::User do
  subject { Importers::User }

  context 'cvs file is valid' do
    let(:valid_users_csv_file) { File.join(Rails.root, 'spec/support/csv/users', 'valid_users.csv') }

    it 'imports new users from the file' do
      expect { subject.new(valid_users_csv_file).import }.to change(User, :count).by(2)
    end
  end

  context 'csv file is not valid' do
    let(:not_uniq_csv_file) do
      File.join(Rails.root, 'spec/support/csv/users', 'not_uniq_users.csv')
    end
    let(:wrong_columns_csv_file) do
      File.join(Rails.root, 'spec/support/csv/users', 'wrong_columns_csv_file.csv')
    end

    let(:invalid_data_csv_file) do
      File.join(Rails.root, 'spec/support/csv/users', 'invalid_data_csv_file.csv')
    end

    it 'imports only 2 new users from the file, skips doubles' do
      expect { subject.new(not_uniq_csv_file).import }.to change(User, :count).by(2)
    end

    it 'got errors when csv file has wrong columns' do
      importer = subject.new(wrong_columns_csv_file)
      importer.import
      expect(importer.has_error?).to be_truthy
      expect(importer.errors_messages).to include('File is invalid, check the columns!')
    end

    it 'got errors when csv file has invalid data' do
      importer = subject.new(invalid_data_csv_file)
      importer.import
      expect(importer.has_error?).to be_truthy
      expect(importer.errors_messages).to include("Record #1 — First name is too long (maximum is 200 characters)")
      expect(importer.errors_messages).to include("Record #2 — Email can't be blank and User name is too long (maximum is 200 characters)")
    end
  end
end
