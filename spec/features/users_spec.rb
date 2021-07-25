require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "user clicks in a room tag" do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div/div[2]/div[2]/div[1]/div/div[2]/div[2]/div[2]/div/div[1]/div/a").click
    expect(page).to have_current_path "/users/#{user.id}/rooms/#{user.rooms[0].id}"
  end
  scenario "user clicks in a modal button", js:true do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div/div[2]/div[2]/div[1]/div/div[2]/div[2]/div[3]/div/div[1]").click
    sleep 1 #so that the modal appears
    expect(page).to have_text "Join a Room"
  end

end
