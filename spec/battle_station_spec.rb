require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation do
  it "generates a Battlestation::Plan" do
    plan = Battlestation::plan {}
    plan.should be_a(Battlestation::Plan)
  end
end
