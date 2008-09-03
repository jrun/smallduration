$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'bigdecimal'
require 'smallduration/error'

class SmallDuration
  include Comparable
  include Enumerable
  
  MULTIPLES = {
    :seconds => 1,
    :minutes => 60,
    :hours   => 3600
  }
  
  UNITS = [
    :fraction, 
    :seconds 
  ]

  attr_reader *UNITS

  # Initialize a duration from the given string representation.
  #
  # Example durations:
  #
  # 9.33      => 9 seconds and 33 hundreths
  # 8:22.11   => 8 minnutes 22 seconds 11 hundreths
  # 67:32     => 1 hour 38 minutes
  # 2:12:09   => 2 hours 12 minutes 9 seconds
  def initialize(duration_str)
    @fraction, @seconds = parse(duration_str)
  end
  
  FORMAT_RE = /\A(((\d+):(\d?\d):)|((\d+):))?(\d?\d)(\.(\d+))?\Z/
  
  def to_d
    BigDecimal("#{@seconds}.#{@fraction}")
  end
  
  private
    def parse(str)
      unless str =~ FORMAT_RE
        raise InvalidFormat.new("Invalid string: #{str}") 
      end
      # the matchdata could have been used to pull out the segments
      # but this seemed easier (to write and understand). unless 
      # i'm missing something there would have been a fair amount 
      # of poking at the match data to pull out each segment.
      left, right = str.split('.')
      parts = left.split(":")
      
      fraction = right.to_i
      
      seconds = [:seconds, :minutes, :hours].inject(0) do |sec, seg|
        sec += (parts.pop.to_i * MULTIPLES[seg])
      end
      [fraction, seconds]
    end
  
end