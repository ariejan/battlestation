require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Plan do
  context "depencies" do
    subject { Battlestation.plan { dependency :postgres } }

    it "are added" do
      subject.dependencies.should be_an(Hash)
      subject.dependencies[:postgres].should be_a(Battlestation::Dependency)
    end

    it "are executed" do
      subject.dependencies[:postgres].should_receive(:execute).once
      subject.execute
    end
  end
end
