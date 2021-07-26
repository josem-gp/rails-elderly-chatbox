require 'rails_helper'

RSpec.feature "Rooms", type: :feature do
  scenario "user goes from one room to another directly" do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "/users/#{user.id}/rooms/#{user.rooms[0].id}"
    find(:xpath, "/html/body/div/div[1]/div[1]/div[2]/div[2]/ul/li[2]/a").click
    expect(page).to have_current_path "/users/#{user.id}/rooms/#{user.rooms[1].id}"
  end
end
