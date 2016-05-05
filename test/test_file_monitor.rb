#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/file_monitor.rb'

describe FileMonitor do
  class TestNotifier < INotify::Notifier
    def watch(filename, action)
      yield
    end
  end

  it 'uses inotify by default' do
    wrapper = FileMonitor.new
    wrapper.monitor.must_be_instance_of(INotify::Notifier)
  end

  it 'uses DoNothing behavior by default' do
    wrapper = FileMonitor.new
    wrapper.behavior.must_be_instance_of DoNothing
  end

  it 'can detect a change to a file' do
    filename = 'sample_file.txt'
    mock_behavior = MiniTest::Mock.new
    wrapper = FileMonitor.new(monitor: TestNotifier.new, behavior: mock_behavior)

    mock_behavior.expect(:on_file_changed, :not_using_return_value_yet, [])

    wrapper.set_action_on_file_changed(filename)

    mock_behavior.verify
  end

  it 'blocks until the first time the file changes' do
    mock_monitor = MiniTest::Mock.new
    wrapper = FileMonitor.new(monitor: mock_monitor)

    mock_monitor.expect(:process, nil, [])

    wrapper.block_until_file_changes

    mock_monitor.verify
  end
end
