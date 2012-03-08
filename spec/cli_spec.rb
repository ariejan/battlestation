require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::CLI do
  context "without a valid Battlestation file" do
    before do
      remove_battlefile
    end

    it "write an error" do
      battlestation :check
      out.should eql("Could not read your Battlestation file")
    end

    it "exits with status 1" do
      battlestation(:check, exitstatus: true).should == 1
    end
  end

  context "with a failing executable-check" do
    it "reports success" do
      check_battlefile <<-B
        Battlestation.plan do
          dependency :some_dep do
            executable 'ls'
          end
        end
      B

      out.should =~ /ls found/i
    end

    it "reports an error" do
      check_battlefile <<-B
        Battlestation.plan do
          dependency :some_dep do
            executable 'unknown-executable-name'
          end
        end
      B

      out.should =~ /unknown-executable-name not found/i
    end
  end
end
