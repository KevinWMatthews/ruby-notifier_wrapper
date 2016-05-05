#!/usr/bin/env ruby

require 'rb-inotify'
require_relative 'behavior.rb'

class FileMonitor
  attr_reader :monitor, :behavior
  def initialize(monitor: INotify::Notifier.new, behavior: DoNothing.new)
    @monitor = monitor
    @behavior = behavior
  end

  def set_action_on_file_changed(filename)
    monitor.watch(filename, :modify) do
      behavior.on_file_changed
    end
  end

  def block_until_file_changes
    monitor.process
  end
end
