class CommentsTable
  def initialize(db)
    @db = db
  end

  def list
    return @db.run("SELECT * FROM comments ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  def list_for_advert_id(id)
    return @db.run("SELECT * FROM comments WHERE advert_id=$1 ORDER BY id;", [id]).map do |row|
      row_to_object(row)
    end
  end

  def add(comment)
    result = @db.run(
      "INSERT INTO comments (contents, advert_id) VALUES ($1, $2) RETURNING id;",
      [comment.contents, comment.advert_id])
    return result[0]["id"]
  end

  private

  def row_to_object(row)
    return CommentEntity.new(
      row["contents"],
      row["advert_id"],
      row["id"]
    )
  end
end
