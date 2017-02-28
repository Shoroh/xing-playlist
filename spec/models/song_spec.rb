require 'rails_helper'

RSpec.describe Song, type: :model do
  %i(title artist album genre).each do |attribute|
    it { should validate_presence_of(attribute) }
  end

  it { should have_many(:playlist_songs) }
  it { should have_many(:playlists).through(:playlist_songs) }
end
