require "advert_entity"

class AdvertsTable
  def initialize(db, comments_table)
    @db = db
    @comments_table = comments_table
  end

  def list
    return @db.run("SELECT * FROM adverts ORDER BY id;").map do |row|
      row_to_object(row)
    end
  end

  def add(advert)
    result = @db.run(
      "INSERT INTO adverts (description, phone_number) VALUES ($1, $2) RETURNING id;",
      [advert.description, advert.phone_number])
    return result[0]["id"]
  end

  def get(index)
    result = @db.run("SELECT * FROM adverts WHERE id = $1;", [index])
    return row_to_object(result[0])
  end

  private

  def row_to_object(row)
    return AdvertEntity.new(
      row["description"],
      row["phone_number"],
      get_comments_for_advert(row["id"]),
      row["id"]
    )
  end

  def get_comments_for_advert(id)
    return @comments_table.list_for_advert_id(id)
  end
end
