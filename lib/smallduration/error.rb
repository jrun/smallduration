class SmallDuration
  class Error < StandardError
  end
  
  class ParseError < Error
  end
  
  class InvalidFormat < Error
  end
end