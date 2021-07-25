require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'user model initialization' do
    it "is valid with a name, alias, municipality, email, password and icon" do
      expect(FactoryBot.create(:user)).to be_valid
    end

    it "is invalid without a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
    it "is invalid without an alias" do
      user = FactoryBot.build(:user, alias: nil)
      user.valid?
      expect(user.errors[:alias]).to include("can't be blank")
    end
    it "is invalid with an alias less that 3 characters" do
      user = FactoryBot.build(:user, alias: 'a')
      user.valid?
      expect(user.errors[:alias]).to include("is too short (minimum is 3 characters)")
    end
    it "is invalid without a municipality" do
      user = FactoryBot.build(:user, municipality: nil)
      user.valid?
      expect(user.errors[:municipality]).to include("can't be blank")
    end
    it "is invalid with a municipality not in the list" do
      user = FactoryBot.build(:user, municipality: 'Hokkaido')
      user.valid?
      expect(user.errors[:municipality]).to include("is not included in the list")
    end
    it "is invalid without an email address" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "is invalid with a duplicate email address" do
      FactoryBot.create(:user, email: "samemail@hotmail.com")
      new_user = FactoryBot.build(:user, email: "samemail@hotmail.com")
      new_user.valid?
      expect(new_user.errors[:email]).to include("has already been taken")
    end
  end
  describe 'user model methods' do
    it "returns the name capitalized" do
      jose = FactoryBot.create(:user, name: 'jose manuel')
      expect(jose.capitalize_first).to eq "Jose Manuel"
    end
  end
end
