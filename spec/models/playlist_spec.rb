require 'rails_helper'

RSpec.describe Playlist, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(200) }

  it { should have_many(:playlist_songs) }
  it { should have_many(:songs).through(:playlist_songs) }
end
