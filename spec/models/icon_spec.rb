require 'rails_helper'

RSpec.describe Icon, type: :model do
  it "is valid with a url from the list" do
    icon = described_class.new(name: "icon1",
                               url: Icon::IMAGES[0])
    expect(icon).to be_valid
  end
  it "is not valid with a url that is not in the list" do
    icon = described_class.new(name: "Chiyoda",
                               url: "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg")
    icon.valid?
    expect(icon.errors[:url]).to include("is not included in the list")
  end
end
