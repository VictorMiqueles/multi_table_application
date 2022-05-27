class CommentEntity
  def initialize(contents, advert_id, id = nil)
    @contents = contents
    @advert_id = advert_id
    @id = id
  end

  def contents
    return @contents
  end

  def advert_id
    return @advert_id
  end

  def id
    return @id
  end
end
