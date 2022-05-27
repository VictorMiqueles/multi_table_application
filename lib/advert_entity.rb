class AdvertEntity
  def initialize(description, phone_number, comments = [], id = nil)
    @description = description
    @phone_number = phone_number
    @comments = comments
    @id = id
  end

  def description
    return @description
  end

  def phone_number
    return @phone_number
  end

  def comments
    return @comments
  end

  def id
    return @id
  end
end
