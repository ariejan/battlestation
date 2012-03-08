require File.dirname(__FILE__) + '/../spec_helper'

describe Battlestation::Operations::Runner do
  context "with a successfully ran command" do
    subject { Battlestation::Operations::Runner.new('ls') }

    before { subject.stub(:system).and_return(true) }

    it { subject.status.should include(status: :okay) }
    it { subject.status.should include(msg: "`ls` executed successfully") }
    it { subject.status.should include(name: "runner-ls") }
  end

  context "with an invalid executable" do
    subject { Battlestation::Operations::Runner.new('does-not-exist') }

    before { subject.stub(:system).and_return(false) }

    it { subject.status.should include(status: :fail) }
    it { subject.status.should include(msg: "`does-not-exist` failed to execute") }
    it { subject.status.should include(name: "runner-does-not-exist") }
  end
end
