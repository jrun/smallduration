require File.dirname(__FILE__) + '/spec_helper.rb'


describe SmallDuration do
  describe '#to_d' do
    it "should be <seconds>.<fraction>" do
     SmallDuration.new('11.99').to_d == 11.99
    end
  end
  
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
  
  describe "comparing" do
    yaml_fixture(:comparisions).each do |example|
      left = SmallDuration.new(example['left'])
      op = example['op']      
      right = SmallDuration.new(example['right'])

      it [left, op, right].join(" ") do
        left.send(op, right).should be_true
      end      
    end
  end
  
end
