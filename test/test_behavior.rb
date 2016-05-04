#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/behavior.rb'

describe DoNothing do
  it 'does nothing' do
    behavior = DoNothing.new
    behavior.on_file_changed
  end
end

describe DesktopNotification do
  it 'uses NotifySend by default' do
    behavior = DesktopNotification.new('dummy message')
    behavior.desktop_notifier.must_be_instance_of NotifySend
  end

  it 'sends a desktop notification' do
    message_summary = "Alert! Alert!"
    message_body = "You have been notified!"
    mock_notifier = MiniTest::Mock.new
    behavior = DesktopNotification.new(message_summary, body: message_body, desktop_notifier: mock_notifier)

    mock_notifier.expect(:send_notification, nil, [message_summary, body: message_body])

    behavior.on_file_changed

    mock_notifier.verify
  end
end
