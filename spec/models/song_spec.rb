require 'rails_helper'

RSpec.describe Song, type: :model do
  %i(title artist album genre).each do |attribute|
    it { should validate_presence_of(attribute) }
  end

  it { should validate_length_of(:title).is_at_most(200) }
  it { should validate_numericality_of(:year).is_greater_than(1900).is_less_than(2100) }
  it { should validate_numericality_of(:track).is_greater_than(0).is_less_than(1_000) }

  it { should have_many(:playlist_songs) }
  it { should have_many(:playlists).through(:playlist_songs) }
end
