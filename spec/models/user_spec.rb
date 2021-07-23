require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with a name, alias, municipality, email, password and icon" do
    icon = Icon.create(name: 'default_icon', url: Icon::IMAGES[0])
    user = described_class.new(name: "Tester",
                               alias: "Test_alias",
                               municipality: "Chiyoda-ku",
                               email: "tester@example.com",
                               password: "1234567",
                               icon: icon)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = described_class.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  it "is invalid without an alias" do
    user = described_class.new(alias: nil)
    user.valid?
    expect(user.errors[:alias]).to include("can't be blank")
  end
  it "is invalid with an alias less that 3 characters" do
    user = described_class.new(alias: 'a')
    user.valid?
    expect(user.errors[:alias]).to include("is too short (minimum is 3 characters)")
  end
  it "is invalid without a municipality" do
    user = described_class.new(municipality: nil)
    user.valid?
    expect(user.errors[:municipality]).to include("can't be blank")
  end
  it "is invalid with a municipality not in the list" do
    user = described_class.new(municipality: 'Hokkaido')
    user.valid?
    expect(user.errors[:municipality]).to include("is not included in the list")
  end
  it "is invalid without an email address" do
    user = described_class.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid without an icon" do
    user = described_class.new(icon: nil)
    user.valid?
    expect(user.errors[:icon]).to include("must exist")
  end
  it "is invalid with a duplicate email address" do
    icon = Icon.create(name: 'default_icon', url: Icon::IMAGES[0])
    described_class.create(name: "Tester1",
                           alias: "Test_alias1",
                           municipality: "Chiyoda-ku",
                           email: "tester@example.com",
                           password: "1234567",
                           icon: icon)
    user = described_class.new(name: "Tester",
                               alias: "Test_alias",
                               municipality: "Chiyoda-ku",
                               email: "tester@example.com",
                               password: "1234567",
                               icon: icon)
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  it "returns the name capitalized" do
    jose = described_class.create(name: "jose manuel",
                                  alias: "jgp",
                                  municipality: "Chiyoda-ku",
                                  email: "jose@example.com",
                                  password: "1234567")
    expect(jose.capitalize_first).to eq "Jose Manuel"
  end
end
