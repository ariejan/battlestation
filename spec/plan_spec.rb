require File.dirname(__FILE__) + '/spec_helper'

describe Battlestation::Plan do
  context "depencies" do
    subject { Battlestation.plan { dependency :postgres } }

    it "are added" do
      subject.tasks.should be_an(Hash)
      subject.tasks[:postgres].should be_a(Battlestation::Task)
    end

    it "are executed" do
      subject.tasks[:postgres].should_receive(:execute).once
      subject.execute
    end
  end
end
