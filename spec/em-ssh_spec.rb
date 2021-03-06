#!/usr/bin/env ruby
require 'bundler/setup'
require 'em-ssh'
require 'rspec'

describe "EM::Ssh" do
  it "should be addressable through EM::P and EM::Protocols" do
    EM::P.const_defined?(:Ssh).should be true
    EM::Protocols.const_defined?(:Ssh).should be true
    EM::P::Ssh.should == EM::Ssh
    EM::Protocols::Ssh.should == EM::Ssh
  end
  it "should raise a ConnectionTimeout error when a connection can't be established before the given timeout" do
    expect {
      EM.run { EM::Ssh.start('192.168.92.11', 'caleb', :timeout => 1) { EM.stop } }
    }.to raise_error(EM::Ssh::ConnectionTimeout)
  end # should raise a ConnectionTimeout error when a connection can't be established before the given timeout
  it "should raise a ConnectionFailed when the address is invalid" do
    expect {
      EM.run { EM::Ssh.start('0.0.0.0', 'caleb') { EM.stop } }
    }.to raise_error(EM::Ssh::ConnectionFailed)
  end # should raise a ConnectionFailed when the address is invalid
end # EM::Ssh
