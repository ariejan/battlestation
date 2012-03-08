require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Task do
  subject {
    Battlestation::Task.new :test_dep do
      executable 'meh'
      process 'some-server'
      run 'some command'
    end
  }

  it { subject.operations.should be_an(Array) }
  it { subject.operations.should have(3).elements }
end
