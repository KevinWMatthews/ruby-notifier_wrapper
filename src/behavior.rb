#!/usr/bin/env ruby

require_relative 'notify_send.rb'

class DoNothing
  def on_file_changed
    return
  end
end

class DesktopNotification
  attr_reader :desktop_notifier, :message
  def initialize(message: nil, desktop_notifier: NotifySend.new)
    @desktop_notifier = desktop_notifier
    @message = message
  end

  def on_file_changed
    desktop_notifier.send_notification(message)
  end
end
