#!/usr/bin/env ruby

class NotifySend
  attr_reader :shell
  def initialize(shell: nil)
    @shell = shell
  end

  def send_notification(notification)
    shell.execute("notify-send #{notification}")
  end
end
