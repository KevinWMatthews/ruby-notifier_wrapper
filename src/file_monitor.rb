#!/usr/bin/env ruby

require 'rb-inotify'

class FileMonitor
  attr_reader :monitor
  def initialize(monitor: INotify::Notifier.new)
    @monitor = monitor
  end

  def block_until_file_changes(filename)
    monitor.watch(filename, :modify) do
      yield if block_given?
    end
    monitor.process
  end

  def block_until_string_is_added_to_file(filename, string)
    monitor.watch(filename, :modify) do
      yield if block_given?
    end
    monitor.run
  end
end
