#!/usr/bin/env ruby

require_relative '../src/notify_send.rb'

notifier = NotifySend.new
notifier.send_notification("Hello world!")