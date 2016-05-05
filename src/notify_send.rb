#!/usr/bin/env ruby

require_relative 'shell.rb'

class NotifySend
    attr_reader :shell, :command
  def initialize(summary: "", body: nil, shell: ShellWrapper.new)
    @command = create_shell_command(summary, body)
    @shell = shell
  end

  def send_notification
    shell.execute( command )
  end

  private
    def create_shell_command(summary, body)
      shell_command = "#{NOTIFY_SEND} #{format_text(summary)} #{format_text(body)}"
      shell_command.strip
    end

    def format_text(text)
      return "" if text.nil?
      "\"#{text}\""
    end

    NOTIFY_SEND = "notify-send"
end
