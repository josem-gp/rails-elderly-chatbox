require 'rails_helper'

RSpec.feature "Pages", type: :feature do
  scenario "user logs in" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link  "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_current_path "/users/#{user.id}"
  end
  scenario "guest signs up" do

  end
end
