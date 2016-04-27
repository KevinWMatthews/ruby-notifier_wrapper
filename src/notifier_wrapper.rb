#!/usr/bin/env ruby

require 'rb-inotify'

class NotifierWrapper
  attr_reader :notifier
  def initialize(notifier: INotify::Notifier.new)
    @notifier = notifier
  end

  def do_something_when_file_changes(filename)
    notifier.watch(filename, :modify) do |event|
      # This is executed when the file is modified.
      # How can I simulate this?
      puts "Your file has changed!"
    end
    notifier.process
  end
end
