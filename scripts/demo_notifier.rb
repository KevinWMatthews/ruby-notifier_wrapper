#!/usr/bin/env ruby

require_relative '../src/notifier_wrapper.rb'
require_relative '../src/behavior.rb'

filename = 'sample_file.txt'
message_summary = "File changed detected!"
message_body = "#{filename} has been modified."
notification = NotifySend.new(summary: message_summary, body: message_body)
behavior = DesktopNotification.new(notification: notification)
notifier = NotifierWrapper.new(behavior: behavior)

notifier.set_action_on_file_changed(filename)
notifier.block_until_file_changes
