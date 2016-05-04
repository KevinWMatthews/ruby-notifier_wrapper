#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/notify_send.rb'

describe NotifySend do
  it 'uses ShellWrapper by default' do
    notifier = NotifySend.new
    notifier.shell.must_be_instance_of ShellWrapper
  end

  it 'sends a notify-send command with a summary to the shell' do
    summary = "Hello world!"
    mock_shell = MiniTest::Mock.new
    notifier = NotifySend.new(shell: mock_shell)

    mock_shell.expect(:execute, nil, ["notify-send \"#{summary}\""])

    notifier.send_notification(summary)

    mock_shell.verify
  end

  it 'sends a notify-send command with a summary and a body to the shell' do
    skip
    summary = "Summary"
    body = "This is the body of the message"
    mock_shell = MiniTest::Mock.new
    notifier = NotifySend.new(shell: mock_shell)

    mock_shell.expect(:execute, nil, ["notify-send \"#{summary}\" \"#{body}\""])

    notifier.send_notification(summary, body: body)

    mock_shell.verify
  end
end
