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
    behavior = DesktopNotification.new()
    behavior.notification.must_be_instance_of NotifySend
  end

  it 'sends a desktop notification' do
    mock_notifier = MiniTest::Mock.new
    behavior = DesktopNotification.new(notification: mock_notifier)

    mock_notifier.expect(:send_notification, nil, [])

    behavior.on_file_changed

    mock_notifier.verify
  end
end
