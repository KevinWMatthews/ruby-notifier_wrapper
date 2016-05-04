#!/usr/bin/env ruby

require_relative 'notify_send.rb'

class DoNothing
  def on_file_changed
    return
  end
end

class DesktopNotification
  attr_reader :desktop_notifier, :summary, :body
  def initialize(summary, body: nil, desktop_notifier: NotifySend.new)
    @desktop_notifier = desktop_notifier
    @summary = summary
    @body = body
  end

  def on_file_changed
    desktop_notifier.send_notification(summary, body: body)
  end
end
