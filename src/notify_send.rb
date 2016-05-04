#!/usr/bin/env ruby

require_relative 'shell.rb'

class NotifySend
  attr_reader :shell
  def initialize(shell: ShellWrapper.new)
    @shell = shell
  end

  def send_notification(summary)
    shell.execute("notify-send \"#{summary}\"")
  end
end
