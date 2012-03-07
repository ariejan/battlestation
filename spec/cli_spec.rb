require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::CLI do
  context "without a valid Battlestation file" do
    it "write an error" do
      battlestation :check
      out.should eql("Could not read your Battlestation file")
    end

    it "exits with status 1" do
      battlestation(:check, exitstatus: true).should == 1
    end
  end
end
