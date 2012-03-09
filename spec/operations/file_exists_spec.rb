require File.dirname(__FILE__) + '/../spec_helper'

describe Battlestation::Operations::FileExistsCheck do
  context "with a file that exists" do
    subject { Battlestation::Operations::FileExistsCheck.new('battlestation.gemspec') }

    before { subject.stub(file_exists?: true) }

    it { subject.status.should include(status: :okay) }
    it { subject.status.should include(msg: "battlestation.gemspec found") }
    it { subject.status.should include(name: "file-battlestation.gemspec") }
  end

  context "with an invalid executable" do
    subject { Battlestation::Operations::FileExistsCheck.new('does-not-exist') }

    it { subject.status.should include(status: :fail) }
    it { subject.status.should include(msg: "does-not-exist not found") }
    it { subject.status.should include(name: "file-does-not-exist") }
  end

  context "with an invalid executable and resolution" do
    subject { Battlestation::Operations::FileExistsCheck.new('does-not-exist', resolution: "copy file") }

    it { subject.status.should include(status: :fail) }
    it { subject.status.should include(msg: "does-not-exist not found") }
    it { subject.status.should include(name: "file-does-not-exist") }
    it { subject.status.should include(resolution: "copy file") }
  end
end
