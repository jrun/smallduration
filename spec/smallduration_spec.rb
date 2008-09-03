require File.dirname(__FILE__) + '/spec_helper.rb'


describe SmallDuration do

  describe "parsing" do
    yaml_fixture(:invalid_formats).each do |bad_value|
      it "should raise a SmallDuration::InvalidFormat when parsing #{bad_value}" do
        lambda do
          SmallDuration.new(bad_value)
        end.should raise_error(SmallDuration::InvalidFormat)
      end
    end
    
    yaml_fixture(:parsing).each do |example|
      value = example['value']
      it "should parse #{value}" do
        duration = SmallDuration.new(value)
        duration.fraction.should == example['fraction']
        duration.seconds.should == example['seconds']
      end      
    end
    
  end
  
end
