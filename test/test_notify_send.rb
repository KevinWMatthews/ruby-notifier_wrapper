#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/notify_send.rb'

describe NotifySend do
  it 'uses ShellWrapper by default' do
    notifier = NotifySend.new
    notifier.shell.must_be_instance_of ShellWrapper
  end

  it 'sends a notify-send command to the shell' do
    notification = "Hello world!"
    mock_shell = MiniTest::Mock.new
    notifier = NotifySend.new(shell: mock_shell)

    mock_shell.expect(:execute, nil, ["notify-send #{notification}"])

    notifier.send_notification(notification)

    mock_shell.verify
  end
end
