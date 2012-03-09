require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation do
  it "generates a Battlestation::Plan" do
    plan = Battlestation::plan {}
    plan.should be_a(Battlestation::Plan)
  end

  context "loading a Battlestation file" do
    before { remove_battlefiles }

    it "loads a Battlestation file" do
      filename = battlefile <<-B
        Battlestation.plan do
        end
      B

      Battlestation.load(filename).should be_a(Battlestation::Plan)
    end

    it "returns nil on error" do
      filename = battlefile <<-B
        Mumbo Jumbo Syntax Dumbo.
      B

      Battlestation.load(filename).should be_nil
    end
  end
end
