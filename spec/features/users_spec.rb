require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "user clicks in a room tag" do
    user = FactoryBot.create(:user, :with_rooms)
    login_as(user)
    visit "users/#{user.id}"
    find(:xpath, "/html/body/div/div[2]/div[2]/div[1]/div/div[2]/div[2]/div[2]/div/div[1]/div/a")
  end
end
