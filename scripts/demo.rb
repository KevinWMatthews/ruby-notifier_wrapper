#!/usr/bin/env ruby

require_relative '../src/notifier_wrapper.rb'
require_relative '../src/behavior.rb'

filename = 'sample_file.txt'
message_summary = "File changed detected!"
message_body = "#{filename} has been modified."
notifier = NotifierWrapper.new( behavior: DesktopNotification.new(message_summary, body: message_body) )

notifier.set_action_on_file_changed(filename)
notifier.block_until_file_changes
