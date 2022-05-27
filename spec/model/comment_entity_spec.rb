require "comment_entity"

RSpec.describe CommentEntity do
  it "constructs" do
    comment = CommentEntity.new(
      "My Contents", # Comment contents
      1, # advert id
      2 # comment id
    )
    expect(comment.contents).to eq "My Contents"
    expect(comment.advert_id).to eq 1
    expect(comment.id).to eq 2
  end
end
