require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Task do
  subject {
    Battlestation::Task.new :test_dep do
      executable 'meh'
      process 'some-server'
      run 'some command'
      file_exists 'some-file'
    end
  }

  it { subject.operations.should be_an(Array) }
  it { subject.operations.should have(4).elements }
end
