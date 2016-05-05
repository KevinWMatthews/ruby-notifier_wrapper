#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../src/file_monitor.rb'

describe FileMonitor do
  class TestNotifier < INotify::Notifier
    attr_reader :mock
    def initialize(mock)
      @mock = mock
    end

    def watch(filename, action)
      yield
    end

    def process
      mock.process
    end
  end

  it 'uses inotify by default' do
    wrapper = FileMonitor.new
    wrapper.monitor.must_be_instance_of(INotify::Notifier)
  end

  describe 'when blocking once' do
    it 'blocks until the file changes' do
      filename = 'sample_file.txt'
      mock_notifier = MiniTest::Mock.new
      wrapper = FileMonitor.new(monitor: TestNotifier.new(mock_notifier))

      mock_notifier.expect(:process, nil, [])

      wrapper.block_until_file_changes(filename)

      mock_notifier.verify
    end

    it 'yields to a block when the file changes' do
      filename = 'sample_file.txt'
      mock_notifier = MiniTest::Mock.new
      mock_behavior = MiniTest::Mock.new
      wrapper = FileMonitor.new(monitor: TestNotifier.new(mock_notifier))

      mock_behavior.expect(:on_file_changed, :not_using_return_value_yet, [])
      mock_notifier.expect(:process, nil, [])

      wrapper.block_until_file_changes(filename) { mock_behavior.on_file_changed }

      mock_behavior.verify
      mock_notifier.verify
    end
  end

  describe 'when blocking indefinitely' do
    it 'can block until a string match is detected' do
      skip
    end
  end
end
