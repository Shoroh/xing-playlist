require 'acceptance_helper'

feature 'Users list' do
  given!(:users) { create_list(:user, 10) }
  given(:first_five_users) { User.ordered.first(5) }
  given(:last_five_users) { User.ordered.last(5) }

  scenario 'Guest sees the users list' do
    visit '/'
    click_on 'Users list'

    within('#users_table') do
      first_five_users.each do |user|
        expect(page).to have_content(user.first_name)
        expect(page).to have_content(user.last_name)
        expect(page).to have_content(user.user_name)
        expect(page).to have_content(user.email)
      end
    end
  end

  scenario 'Guest sees the second page of the users list' do
    visit '/users'
    within('ul.pagination') do
      click_on('2')
    end

    within('#users_table') do
      last_five_users.each do |user|
        expect(page).to have_content(user.first_name)
        expect(page).to have_content(user.last_name)
        expect(page).to have_content(user.user_name)
        expect(page).to have_content(user.email)
      end
    end
  end
end
