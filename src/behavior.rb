#!/usr/bin/env ruby

require_relative 'notify_send.rb'

class DoNothing
  def on_file_changed
    return
  end
end

class DesktopNotification
  attr_reader :notification
  def initialize(notification: NotifySend.new)
    @notification = notification
  end

  def on_file_changed
    notification.send_notification
  end
end
