require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, alias, municipality, email, password and icon" do
    icon = Icon.create(name: 'default_icon', url: Icon::IMAGES[0])
    user = User.new(name: "Tester",
                    alias: "Test_alias",
                    municipality: "Chiyoda-ku",
                    email: "tester@example.com",
                    password: "1234567",
                    icon: icon)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  it "is invalid without an alias" do
    user = User.new(alias: nil)
    user.valid?
    expect(user.errors[:alias]).to include("can't be blank")
  end
  it "is invalid with an alias less that 3 characters" do
    user = User.new(alias: 'a')
    user.valid?
    expect(user.errors[:alias]).to include("is too short (minimum is 3 characters)")
  end
  it "is invalid without a municipality" do
    user = User.new(municipality: nil)
    user.valid?
    expect(user.errors[:municipality]).to include("can't be blank")
  end
  it "is invalid with a municipality not in the list" do
    user = User.new(municipality: 'Hokkaido')
    user.valid?
    expect(user.errors[:municipality]).to include("is not included in the list")
  end
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid without an icon" do
    user = User.new(icon: nil)
    user.valid?
    expect(user.errors[:icon]).to include("must exist")
  end
  it "is invalid with a duplicate email address" do
    icon = Icon.create(name: 'default_icon', url: Icon::IMAGES[0])
    User.create(name: "Tester1",
                alias: "Test_alias1",
                municipality: "Chiyoda-ku",
                email: "tester@example.com",
                password: "1234567",
                icon: icon)
    user = User.new(name: "Tester",
                    alias: "Test_alias",
                    municipality: "Chiyoda-ku",
                    email: "tester@example.com",
                    password: "1234567",
                    icon: icon)
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  it "does not allow duplicate room for a user"
  it "allows several users to have the same room"
end
