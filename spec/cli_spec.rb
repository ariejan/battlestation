require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::CLI do
  context "Battlestation files" do
    before do
      remove_battlefile
    end

    it "uses a Battlestation file" do
      battlefile <<-B
        Battlestation.plan do
        end
      B
      battlestation(:check)

      out.should_not =~ /Could not read your Battlestation file/
    end

    it "checks for a Battlestation.rb file" do
      battlefilerb <<-B
        Battlestation.plan do
        end
      B
      battlestation(:check)

      out.should_not =~ /Could not read your Battlestation file/
    end

    it "complains when both Battlestation and Battlestation.rb exist" do
      battlefile <<-B
        Battlestation.plan do
        end
      B

      battlefilerb <<-B
        Battlestation.plan do
        end
      B

      battlestation(:check)

      out.should =~ /You cannot have both Battlestation and Battlestation.rb files. Choose one, remove the other./
    end

    context "without a valid Battlestation file" do
      it "write an error" do
        battlestation :check
        out.should =~ /Could not read your Battlestation file/
      end

      it "exits with status 1" do
        battlestation(:check, exitstatus: true).should == 1
      end
    end

    context "with a Battlestation file with syntax errors" do
      it "reports syntax errors in your Battlestation" do
        check_battlefile <<-B
          Syntactic Mumbo Jumbo
        B

        out.should =~ /Your Battlestation has syntax errors/
      end
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

      out.should =~ / \[OKAY\] ls executable found/i
    end

    it "reports an error" do
      check_battlefile <<-B
        Battlestation.plan do
          dependency :some_dep do
            executable 'unknown-executable-name'
          end
        end
      B

      out.should =~ / \[FAIL\] unknown-executable-name executable not found/i
    end

    it "exists with error status 1 on failure" do
      battlefile <<-B
        Battlestation.plan do
          dependency :some_dep do
            executable 'unknown-executable-name'
          end
        end
      B

      battlestation(:check, exitstatus: true).should == 1
    end

    it "reports resolutions on failure" do
      check_battlefile <<-B
        Battlestation.plan do
          dependency :some_dep do
            executable 'unknown-executable-name', resolution: "Install some app"
          end
        end
      B

      out.should =~ /Install some app/i
    end
  end
end
