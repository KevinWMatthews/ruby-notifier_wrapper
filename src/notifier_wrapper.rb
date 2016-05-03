#!/usr/bin/env ruby

require 'rb-inotify'

class NotifierWrapper
  attr_reader :notifier
  def initialize(notifier: INotify::Notifier.new)
    @notifier = notifier
  end

  def set_action_on_file_changed(filename)
    notifier.watch(filename, :modify) do
      yield
    end
  end

  def block_until_file_changes
    notifier.process
  end
end
