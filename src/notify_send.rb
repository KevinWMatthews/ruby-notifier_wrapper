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
      shell_command = "#{NOTIFY_SEND} #{format_text(summary)} #{format_text(body)}"
      shell_command.strip
    end

    def format_text(text)
      return "" if text.nil?
      "\"#{text}\""
    end

    NOTIFY_SEND = "notify-send"
end
