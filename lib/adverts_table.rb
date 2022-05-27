require "advert_entity"

class AdvertsTable
  def initialize(db)
    @db = db
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
      row["id"]
    )
  end
end
