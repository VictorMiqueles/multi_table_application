require "advert_entity"

RSpec.describe AdvertEntity do
  it "constructs" do
    advert = AdvertEntity.new("My Description", "+447800000000", 4)
    expect(advert.description).to eq "My Description"
    expect(advert.phone_number).to eq "+447800000000"
    expect(advert.id).to eq 4
  end
end
