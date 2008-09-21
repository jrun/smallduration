$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'bigdecimal'
require 'smallduration/error'

class SmallDuration
  include Comparable

  MULTIPLES = {
    :seconds => 1,
    :minutes => 60,
    :hours   => 3600
  }
  
  PARTS = [
    :fraction, 
    :seconds 
  ]

  attr_reader *PARTS

  # Initializes a SmallDuration using the given duration.
  #
  # ==== Parameters
  # duration<to_s>:: The duration to parse. 
  #
  # ==== Examples
  #
  # 9.33      => 9.33 seconds
  # 8:22.11   => 502.11 seconds
  # 67:32     => 4052 seconds
  # 2:12:09   => 7929 seconds
  #
  def initialize(duration)
    @fraction, @fraction_padding, @seconds = parse(duration.to_s)
  end
  
  def to_s
    "#{@seconds}.#{'0' * @fraction_padding}#{@fraction}"
  end
  
  def to_d
    BigDecimal(to_s)
  end
  
  # Implement Comparison
  #
  # ==== Parameters
  # other<to_d>:: The object to comapre to.
  def <=>(other)
    self.to_d <=> (other.respond_to?(:to_d) ? other.to_d : other)
  end
  
  private
    FORMAT_RE = /\A(((\d+):(\d?\d):)|((\d+):))?(\d?\d)(\.(\d+))?\Z/
    
    def parse(str)
      raise InvalidFormat.new(str) unless str =~ FORMAT_RE
      # the matchdata could have been used to pull out the parts
      # but this seemed easier (to write and understand). there 
      # would have been a fair amount of understanding what each 
      # parts was.
      left, right = str.split('.')
      parts = left.split(":")
      
      if right
        fraction = right.to_i
        fraction_padding = right.length - fraction.to_s.length
      else
        fraction, fraction_padding = 0,0
      end
            
      seconds = [:seconds, :minutes, :hours].inject(0) do |sum, multiple|
        sum + parts.pop.to_i * MULTIPLES[multiple]
      end
      [fraction, fraction_padding, seconds]
    end
end