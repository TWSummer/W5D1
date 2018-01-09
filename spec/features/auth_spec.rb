require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit( new_user_url )
    expect(page).to have_content("Sign Up")
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      user = FactoryBot.build(:user)
      visit(new_user_url)
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Sign Up"
      expect(page).to have_content(user.username)
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    user = FactoryBot.create(:user)
    visit(new_session_url)
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Sign In"
    expect(page).to have_content(user.username)
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit(new_session_url)
    expect(page).to have_content('Sign In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    user = FactoryBot.create(:user)
    visit(new_session_url)
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Sign In"
    click_on "Sign Out"
    expect(page).to have_content("Sign In")
    expect(page).not_to have_content(user.username)
  end
end
