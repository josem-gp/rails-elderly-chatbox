require 'rails_helper'

RSpec.feature "Users", type: :feature do
  user = FactoryBot.create(:user, email: 'tester3@tester.com', alias: 'noalias3')
  scenario "user logs out" do
    visit "users/#{user.id}"
    click_link "Log out"
    expect(page).to have_text('Signed out successfully')
  end
end
