require "helpers/database_helpers"
require "comments_table"
require "comment_entity"

RSpec.describe CommentsTable do
  def clean_and_get_database
    DatabaseHelpers.clear_table("comments")
    return DatabaseHelpers.test_db_connection
  end

  it "starts with an empty table" do
    db = clean_and_get_database
    comments_table = CommentsTable.new(db)
    expect(comments_table.list).to eq([])
  end

  it "adds and lists out comments" do
    db = clean_and_get_database
    comments_table = CommentsTable.new(db)
    adverts_table = AdvertsTable.new(db, comments_table)

    advert_id = adverts_table.add(AdvertEntity.new("My Advert Contents", "07800000000"))
    comments_table.add(CommentEntity.new(
      "My Comment Contents",
      advert_id
    ))

    comments = comments_table.list
    expect(comments[0].contents).to eq "My Comment Contents"
    expect(comments[0].advert_id).to eq advert_id
  end

  it "lists out comments only for a particular advert" do
    db = clean_and_get_database
    comments_table = CommentsTable.new(db)
    adverts_table = AdvertsTable.new(db, comments_table)

    advert_id_1 = adverts_table.add(AdvertEntity.new("I've lost my cat!", "07800000000"))
    advert_id_2 = adverts_table.add(AdvertEntity.new("My Advert Contents 2", "07800000000"))
    comments_table.add(CommentEntity.new(
      "I saw it on Grange Road",
      advert_id_1
    ))

    comments_for_advert_id_1 = comments_table.list_for_advert_id(advert_id_1)
    expect(comments_for_advert_id_1.length).to eq 1
    expect(comments_for_advert_id_1[0].contents).to eq "I saw it on Grange Road"

    comments_for_advert_id_2 = comments_table.list_for_advert_id(advert_id_2)
    expect(comments_for_advert_id_2).to eq []
  end
end
