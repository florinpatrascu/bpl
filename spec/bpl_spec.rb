require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'active_record'
require "models/blood_pressure"
require "bpl"

include Bpl
now = Time.now

opts = {
 :date => now.strftime(DATE_FORMAT),
 :time => now.strftime(TIME_FORMAT),
 :quiet => true,
 :all => true
}

Bpl.options opts

describe "BPL main functions" do
  describe "Database" do
    it "should have the database ready" do
      BloodPressure.all.should have(0).items
    end
  end
  
  describe "CRUD functionality" do
    it "should add a new record" do
      bp = Bpl.add 120, 80, 66, 'l', 85
      BloodPressure.all.should have(1).items
      bp.date_collected.strftime(DATE_FORMAT).should eql(now.strftime(DATE_FORMAT)) 
      bp.time_collected.strftime(TIME_FORMAT).should eql(now.strftime(TIME_FORMAT)) 
    end
    
    it "should delete a record by record id" do
      bp = BloodPressure.first
      bp.should_not be_nil
      
      Bpl.remove bp.id
      BloodPressure.all.should have(0).items
    end    
  end
  
  describe "Exporting the data" do
    it "should have some data" do
      10.times do |x|
        bp = Bpl.add(Random.rand(120...160), Random.rand(60...95), Random.rand(55...101), 
                x % 2 == 0 ? 'l' : 'r', Random.rand(75...110)) 
      end
      
      BloodPressure.all_records.should have(10).items
    end    

    it "should export 11 records" do
      data = Bpl.export
      data.scan("\n").count.should == 11 # including the header
    end
  end
end