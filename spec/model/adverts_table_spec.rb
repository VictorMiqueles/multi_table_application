require "helpers/database_helpers"
require "advert_entity"
require "adverts_table"
require "comment_entity"
require "comments_table"

RSpec.describe AdvertsTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("comments")
    DatabaseHelpers.clear_table("adverts")
    return DatabaseHelpers.test_db_connection
  end

  it "start with an empty table" do
    db = clean_and_get_database
    comments_table = CommentsTable.new(db)
    adverts_table = AdvertsTable.new(db, comments_table)
    expect(adverts_table.list).to eq([])
  end

  it "adds adverts and lists them out again" do
    db = clean_and_get_database
    comments_table = CommentsTable.new(db)
    adverts_table = AdvertsTable.new(db, comments_table)
    adverts_table.add(AdvertEntity.new("My Description", "+4407800000000"))

    adverts = adverts_table.list
    expect(adverts.length).to eq 1
    expect(adverts[0].description).to eq "My Description"
    expect(adverts[0].phone_number).to eq "+4407800000000"
  end

  it "lists out adverts with their comments" do
    db = clean_and_get_database

    comments_table = CommentsTable.new(db)
    adverts_table = AdvertsTable.new(db, comments_table)
    advert_id_1 = adverts_table.add(AdvertEntity.new("My Description 1", "+4407800000000"))
    advert_id_2 = adverts_table.add(AdvertEntity.new("My Description 2", "+4407800000000"))

    comments_table.add(CommentEntity.new("Comment Contents 1", advert_id_1))
    comments_table.add(CommentEntity.new("Comment Contents 2", advert_id_1))

    adverts = adverts_table.list
    expect(adverts[0].comments[0].contents).to eq "Comment Contents 1"
    expect(adverts[0].comments[1].contents).to eq "Comment Contents 2"
    expect(adverts[1].comments).to eq []
  end

  it "gets a single advert" do
    db = clean_and_get_database
    comments_table = CommentsTable.new(db)
    adverts_table = AdvertsTable.new(db, comments_table)

    ad1 = adverts_table.add(AdvertEntity.new("My Description 1", "+4407800000000"))
    ad2 = adverts_table.add(AdvertEntity.new("My Description 2", "+4407800000001"))
    ad3 = adverts_table.add(AdvertEntity.new("My Description 3", "+4407800000002"))

    advert = adverts_table.get(ad2)
    expect(advert.description).to eq "My Description 2"
  end
end
