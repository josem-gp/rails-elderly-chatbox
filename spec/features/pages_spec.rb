require 'rails_helper'

RSpec.feature "Pages", type: :feature do
  scenario "user logs in" do
    user = FactoryBot.create(:user, email: 'tester@tester.com', alias: 'noalias')

    visit root_path
    click_link  "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_current_path "/users/#{user.id}"
  end
  scenario "user logs in with wrong information" do
    user = FactoryBot.create(:user, email: 'tester@tester.com', alias: 'noalias')

    visit root_path
    click_link  "Log in"
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_text('Invalid Email or password')
  end
  scenario "guest signs up" do
    visit root_path
    click_link "Sign up"
    fill_in "Name", with: "jose"
    fill_in "Alias", with: "jgptest"
    select "Adachi-ku", from: "Municipality"
    fill_in "Email", with: "test@test.com"
    within ".user_password" do
      fill_in 'Password', with: 'password' #it didnt work with a simply fill_in so i had to use a within
    end
    click_button "Create a new account"
    # save_and_open_page #=> for debugging purposes

    expect(page).to have_text('Welcome! You have signed up successfully.')
  end
  scenario "guest signs up with wrong information" do
    visit root_path
    click_link "Sign up"
    fill_in "Name", with: "jose"
    fill_in "Alias", with: "j"
    select "Adachi-ku", from: "Municipality"
    fill_in "Email", with: "test@test.com"
    within ".user_password" do
      fill_in 'Password', with: 'password' #it didnt work with a simply fill_in so i had to use a within
    end
    click_button "Create a new account"
    # save_and_open_page #=> for debugging purposes

    expect(page).to have_text('Please review the problems below')
  end
end
