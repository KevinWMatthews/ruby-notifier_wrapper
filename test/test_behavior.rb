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
  it 'sends a desktop notification' do
    message = "You have been notified!"
    mock_notifier = MiniTest::Mock.new
    behavior = DesktopNotification.new(message: message, desktop_notifier: mock_notifier)

    mock_notifier.expect(:send_notification, nil, [message])

    behavior.on_file_changed

    mock_notifier.verify
  end
end
