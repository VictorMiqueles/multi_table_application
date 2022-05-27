class AdvertEntity
  def initialize(description, phone_number, id = nil)
    @description = description
    @phone_number = phone_number
    @id = id
  end

  def description
    return @description
  end

  def phone_number
    return @phone_number
  end

  def id
    return @id
  end
end
