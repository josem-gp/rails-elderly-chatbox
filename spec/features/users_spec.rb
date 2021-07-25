require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "user logs out" do
    user = FactoryBot.create(:user)
    visit "users/#{user.id}"
    within ".dropdown-item" do
      click_link "Log out"
    end
    expect(page).to have_text('Signed out successfully')
  end
end
