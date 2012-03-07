require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Dependency do
  it "add an executable to check" do
    dep = Battlestation::Dependency.new :test_dep do
      executable 'autoexec.bat'
    end

    dep.executables.should be_an(Array)
    dep.executables.should have(1).element
    dep.executables.should include('autoexec.bat')
  end
end

