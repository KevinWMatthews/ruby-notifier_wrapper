#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/notify_send.rb'

describe NotifySend do
  it 'uses Shell by default' do
    notifier = NotifySend.new
    notifier.shell.must_be_instance_of Shell
  end

  it 'sends a notify-send command with a summary to the shell' do
    summary = "Hello world!"
    mock_shell = MiniTest::Mock.new
    notifier = NotifySend.new(summary: summary, shell: mock_shell)

    mock_shell.expect(:execute, nil, ["notify-send \"#{summary}\""])

    notifier.send_notification

    mock_shell.verify
  end

  it 'sends a notify-send command with a summary and a body to the shell' do
    summary = "Summary"
    body = "This is the body of the message"
    mock_shell = MiniTest::Mock.new
    notifier = NotifySend.new(summary: summary, body: body, shell: mock_shell)

    mock_shell.expect(:execute, nil, ["notify-send \"#{summary}\" \"#{body}\""])

    notifier.send_notification

    mock_shell.verify
  end
end
