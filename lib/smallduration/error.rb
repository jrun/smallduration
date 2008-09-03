class SmallDuration
  class Error < StandardError
  end
  
  class ParseError < Error
  end
  
  class InvalidFormat < Error
    def initialize(invalid_str)
      super "Invalid string: #{invalid_str}"
    end
  end
  
end