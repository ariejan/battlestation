require File.dirname(__FILE__) + '/../spec_helper'

describe Battlestation::Checks::Executable do
  context "with a valid executable" do
    subject { Battlestation::Checks::Executable.new('ls') }

    it { subject.status.should include(status: :okay) }
    it { subject.status.should include(msg: "ls executable found") }
    it { subject.status.should include(name: "executable-ls") }
  end

  context "with an invalid executable" do
    subject { Battlestation::Checks::Executable.new('does-not-exist') }

    it { subject.status.should include(status: :fail) }
    it { subject.status.should include(msg: "does-not-exist executable not found") }
    it { subject.status.should include(name: "executable-does-not-exist") }
  end

  context "with an invalid executable and resolution" do
    subject { Battlestation::Checks::Executable.new('does-not-exist', resolution: "install some package") }

    it { subject.status.should include(status: :fail) }
    it { subject.status.should include(msg: "does-not-exist executable not found") }
    it { subject.status.should include(name: "executable-does-not-exist") }
    it { subject.status.should include(resolution: "install some package") }
  end
end
