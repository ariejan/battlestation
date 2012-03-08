require File.dirname(__FILE__) + '/../spec_helper'

describe Battlestation::Operations::ProcessCheck do
  context "with a valid process" do
    subject { Battlestation::Operations::ProcessCheck.new('ruby') }

    it { subject.status.should include(status: :okay) }
    it { subject.status.should include(msg: "ruby up and running") }
    it { subject.status.should include(name: "process-ruby") }
  end

  context "with an invalid process" do
    subject { Battlestation::Operations::ProcessCheck.new('does-not-exist') }

    it { subject.status.should include(status: :warn) }
    it { subject.status.should include(msg: "does-not-exist not running") }
    it { subject.status.should include(name: "process-does-not-exist") }
  end

  context "with an invalid process and forced error" do
    subject { Battlestation::Operations::ProcessCheck.new('does-not-exist', error: true) }

    it { subject.status.should include(status: :fail) }
    it { subject.status.should include(msg: "does-not-exist not running") }
    it { subject.status.should include(name: "process-does-not-exist") }
  end

  context "with an invalid process and resolution" do
    subject { Battlestation::Operations::ProcessCheck.new('does-not-exist', resolution: "install some package") }

    it { subject.status.should include(status: :warn) }
    it { subject.status.should include(msg: "does-not-exist not running") }
    it { subject.status.should include(name: "process-does-not-exist") }
    it { subject.status.should include(resolution: "install some package") }
  end
end
