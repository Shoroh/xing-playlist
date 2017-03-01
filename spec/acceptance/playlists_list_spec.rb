require 'acceptance_helper'

feature 'Playlists list' do
  given(:songs) { create_list(:song, 10) }
  given(:user) { create(:user) }
  given!(:playlists) { create_list(:playlist, 10, user: user, songs: songs) }

  scenario 'Guest sees the users playlists list' do
    visit '/users'
    click_on "#{user.first_name}"

    within('#playlists_table') do
      playlists.each do |playlist|
        expect(page).to have_content(playlist.name)
      end
    end
  end
end
