require "helpers/database_helpers"
require "advert_entity"
require "adverts_table"

RSpec.describe AdvertsTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("adverts")
    return DatabaseHelpers.test_db_connection
  end

  it "start with an empty table" do
    db = clean_and_get_database
    adverts_table = AdvertsTable.new(db)
    expect(adverts_table.list).to eq([])
  end

  it "adds adverts and lists them out again" do
    db = clean_and_get_database
    adverts_table = AdvertsTable.new(db)
    adverts_table.add(AdvertEntity.new("My Description", "+4407800000000"))

    adverts = adverts_table.list
    expect(adverts.length).to eq 1
    expect(adverts[0].description).to eq "My Description"
    expect(adverts[0].phone_number).to eq "+4407800000000"
  end

  it "gets a single advert" do
    db = clean_and_get_database
    adverts_table = AdvertsTable.new(db)

    ad1 = adverts_table.add(AdvertEntity.new("My Description 1", "+4407800000000"))
    ad2 = adverts_table.add(AdvertEntity.new("My Description 2", "+4407800000001"))
    ad3 = adverts_table.add(AdvertEntity.new("My Description 3", "+4407800000002"))

    advert = adverts_table.get(ad2)
    expect(advert.description).to eq "My Description 2"
  end
end
