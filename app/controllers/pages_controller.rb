class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    admin = User.find_by(name: 'admin')
    if admin
      participants = admin.participants
      participants.destroy_all
      admin.delete
      Shop.destroy_all
    end
    admin = User.create!(name: 'admin', age: 28, municipality: 'Chuo-ku', alias: 'admin', email: 'admin@hotmail.com', password: '1234567')
    require "open-uri"
    require "json"
    response = open("https://good-neighbour-api.herokuapp.com/api/v1/shops").read
    json = JSON.parse(response)
    json.each do |shop|
      name = shop['name']
      address = shop['address']
      phone_number = shop['phone_number']
      website = shop['website']
      image = shop['images']

      file = URI.open(image)
      shop_seed = Shop.new(name: name, address: address, phone_number: phone_number, website: website, user_id: admin)
      shop_seed.photos.attach(io: file, filename: 'shop.jgp', content_type: 'image/jgp')
      shop_seed.save!
    end
  end
end
