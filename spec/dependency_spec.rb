require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Dependency do
  subject {
    Battlestation::Dependency.new :test_dep do
      executable 'meh'
      process 'some-server'
    end
  }

  it { subject.checks.should be_an(Array) }
  it { subject.checks.should have(2).elements }
end
