#!/usr/bin/env ruby

require_relative 'shell.rb'

class NotifySend
  attr_reader :shell
  def initialize(shell: ShellWrapper.new)
    @shell = shell
  end

  def send_notification(summary, body: nil)
    shell.execute( create_notification(summary, body) )
  end

  private
    def create_notification(summary, body)
      "#{NOTIFY_SEND} #{format_text(summary)}"
    end

    def format_text(text)
      "\"#{text}\""
    end

    NOTIFY_SEND = "notify-send"
end
