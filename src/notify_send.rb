#!/usr/bin/env ruby

require_relative 'shell.rb'

class NotifySend
  attr_reader :shell
  def initialize(shell: ShellWrapper.new)
    @shell = shell
  end

  def send_notification(notification)
    shell.execute("notify-send #{notification}")
  end
end
