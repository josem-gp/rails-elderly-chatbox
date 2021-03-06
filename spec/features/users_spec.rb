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
  scenario "user joins a room", js:true do
    user = FactoryBot.create(:user, :with_rooms)
    Room.create(name: "Fussa", room_type: "private")
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div/div[2]/div[2]/div[1]/div/div[2]/div[2]/div[3]/div/div[1]").click
    sleep 1 #so that the modal appears
    expect{
      select "Fussa", from: "Room"
      click_button "Join"
    }.to change(user.rooms, :count).by(1)
  end
  scenario "user creates a post", js:true do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div[1]/div[2]/div[2]/div[1]/div/div[2]/div[2]/div[3]/div/div[5]").click
    sleep 1 #so that the modal appears
    expect{
      fill_in "Content", with: "hey come see the event!"
      select "General", from: "Room"
      click_button "Post it!"
    }.to change(user.events, :count).by(1)
  end
  scenario "user clicks in the vertical navbar", js:true do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div/div[1]/ul/li[2]/a").click
    sleep 1
    expect(page).to have_text "My Page"
  end
  scenario "user clicks the log out button", js:true do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div/div[2]/div[1]/div/ul/li").click
    find(:xpath, "/html/body/div/div[2]/div[1]/div/ul/li/div/a").click
    expect(page).to have_text "Signed out successfully"
  end
end
