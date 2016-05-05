#!/usr/bin/env ruby

require_relative '../src/file_monitor.rb'
require_relative '../src/notify_send.rb'

filename = 'sample_file.txt'
message_summary = "File changed detected!"
message_body = "#{filename} has been modified."
notification = NotifySend.new(summary: message_summary, body: message_body)
file_monitor = FileMonitor.new

file_monitor.block_until_file_changes(filename) { notification.send_notification }
