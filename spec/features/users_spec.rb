require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario "user clicks in a room tag" do
    user = FactoryBot.create(:user)
    login_as(user)
    visit "users/#{user.id}"
    save_and_open_page #cuando miro esto, veo que no se han asignado las "rooms". quizás tenga que hacerlo manualmente ya que es un test
    find(:xpath, "/html/body/div/div[2]/div[2]/div[1]/div/div[2]/div[2]/div[2]/div/div[1]/div/a")
  end
end
