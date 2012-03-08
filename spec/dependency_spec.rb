require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Dependency do
  context "executables" do
    subject {
      Battlestation::Dependency.new :test_dep do
        executable 'autoexec.bat'
      end
    }

    it "can be added" do
      subject.executables.should be_an(Array)
      subject.executables.should have(1).element
      subject.executables.should include('autoexec.bat')
    end

    it "can be executed" do
      subject.should_receive(:system).with('/usr/bin/env which autoexec.bat &> /dev/null')
      subject.execute
    end

    it "returns a result when succesful" do
      subject.should_receive(:system).with('/usr/bin/env which autoexec.bat &> /dev/null').and_return(true)
      result = subject.execute

      result.should be_an(Array)
      result.should have(1).element
      result.should include(okay: "autoexec.bat found")
    end

    it "returns a result when not succesful" do
      subject.should_receive(:system).with('/usr/bin/env which autoexec.bat &> /dev/null').and_return(false)
      result = subject.execute

      result.should be_an(Array)
      result.should have(1).elements
      result.should include(fail: "autoexec.bat not found")
    end
  end
end

