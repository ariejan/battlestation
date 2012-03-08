require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Dependency do
  context "processes" do
    subject {
      Battlestation::Dependency.new :test_dep do
        process 'some-server'
      end
    }

    it "can be added" do
      subject.processes.should be_an(Array)
      subject.processes.should have(1).elements

      process = subject.processes.first
      process.should include(identifier: 'some-server')
    end

    it "can be executed" do
      subject.should_receive(:process_running?).with('some-server')
      subject.execute
    end

    it "returns a result when succesful" do
      subject.should_receive(:process_running?).with('some-server').and_return(true)
      result = subject.execute

      result.should be_an(Array)
      result.should have(1).element

      status = result.first
      status.should include(status: :okay, msg: "some-server up and running", name: "process-some-server")
    end

    it "returns a result when not succesful" do
      subject.should_receive(:process_running?).with('some-server').and_return(false)
      result = subject.execute

      result.should be_an(Array)
      result.should have(1).elements

      status = result.first
      status.should include(status: :warn, msg: "some-server not running", name: "process-some-server")
    end

    context "with error: true" do
      subject {
        Battlestation::Dependency.new :test_dep do
          process 'some-server', error: true
        end
      }

      it "can be added" do
        subject.processes.should be_an(Array)
        subject.processes.should have(1).elements

        process = subject.processes.first
        process.should include(identifier: 'some-server', opts: { error: true })
      end

      it "returns a result when not succesful" do
        subject.should_receive(:process_running?).with('some-server').and_return(false)
        result = subject.execute

        result.should be_an(Array)
        result.should have(1).elements

        status = result.first
        status.should include(status: :fail, msg: "some-server not running", name: "process-some-server")
      end
    end
  end

  context "executables" do
    subject {
      Battlestation::Dependency.new :test_dep do
        executable 'autoexec.bat', resolution: "Install DOS"
      end
    }

    it "can be added" do
      subject.executables.should be_an(Array)
      subject.executables.should have(1).element

      executable = subject.executables.first
      executable.should include(filename: 'autoexec.bat', opts: { resolution: "Install DOS" })
    end

    it "can be executed" do
      subject.should_receive(:executable_exists?).with('autoexec.bat')
      subject.execute
    end

    it "returns a result when succesful" do
      subject.should_receive(:executable_exists?).with('autoexec.bat').and_return(true)
      result = subject.execute

      result.should be_an(Array)
      result.should have(1).element

      status = result.first
      status.should include(status: :okay, msg: "autoexec.bat found", name: "executable-autoexec.bat")
    end

    it "returns a result when not succesful" do
      subject.should_receive(:executable_exists?).with('autoexec.bat').and_return(false)
      result = subject.execute

      result.should be_an(Array)
      result.should have(1).elements

      status = result.first
      status.should include(status: :fail, msg: "autoexec.bat not found", name: "executable-autoexec.bat", resolution: "Install DOS")
    end
  end
end

