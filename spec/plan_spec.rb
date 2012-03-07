require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Plan do
  it "adds dependencies" do
    plan = Battlestation.plan { dependency :postgres }
    plan.dependencies.should be_an(Hash)
    plan.dependencies[:postgres].should be_a(Battlestation::Dependency)
  end
end

