#!/usr/bin/env ruby

require 'rb-inotify'

class NotifierWrapper
  attr_reader :notifier, :behavior
  def initialize(notifier: INotify::Notifier.new, behavior: nil)
    @notifier = notifier
    @behavior = behavior
  end

  def set_action_on_file_changed(filename)
    notifier.watch(filename, :modify) do
      behavior.on_file_changed
    end
  end

  def block_until_file_changes
    notifier.process
  end
end
