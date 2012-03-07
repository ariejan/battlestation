require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Dependency do
  context "executables" do
    subject {
      dep = Battlestation::Dependency.new :test_dep do
        executable 'autoexec.bat'
      end
    }

    it "can be added" do
      subject.executables.should be_an(Array)
      subject.executables.should have(1).element
      subject.executables.should include('autoexec.bat')
    end

    it "can be executed" do
      subject.should_receive(:system).with('which -s autoexec.bat')
      subject.execute
    end
  end
end

